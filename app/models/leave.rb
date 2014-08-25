class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(date: :desc, id: :asc) }
  scope :approve, -> { where(status: :approve) }
  scope :reject, -> { where(status: :reject) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true
  delegate :id, :date, :kind, to: :leave_day, prefix: true, allow_nil: true

  has_many :leave_days, dependent: :delete_all
  accepts_nested_attributes_for :leave_days, :update_only => true
  belongs_to :staff

  validates :status, :reason, :staff, :category, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  def leave_days_first_date
    self.leave_days.first.date
  end

  def leave_days_last_date
    self.leave_days.last.date
  end

  def leave_days_count
    self.leave_days.whole_day.count + self.leave_days.half_day.count
  end

  def leave_dates
    if self.leave_days.count == 1
      "on #{leave_days_first_date}"
    else
      "from #{leave_days_first_date} to #{leave_days_last_date}"
    end
  end

end
