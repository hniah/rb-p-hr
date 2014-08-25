class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(id: :desc) }
  scope :approve, -> { where(status: :approve) }
  scope :reject, -> { where(status: :reject) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true
  delegate :id, :date, :kind, to: :leave_day, prefix: true, allow_nil: true

  has_many :leave_days, dependent: :delete_all
  accepts_nested_attributes_for :leave_days, :update_only => true, :allow_destroy => true
  belongs_to :staff

  validates :status, :reason, :staff, :category, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  def first_date
    self.leave_days.first.date
  end

  def last_date
    self.leave_days.last.date
  end

  def days_total
    self.leave_days.whole_day.count + self.leave_days.half_day.count / 2.0
  end

  def dates
    if self.leave_days.count == 1
      "on #{first_date}"
    else
      "from #{first_date} to #{last_date}"
    end
  end

end
