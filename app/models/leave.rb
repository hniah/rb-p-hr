class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(date: :desc, id: :asc) }
  scope :approve, -> { where(status: :approve) }
  scope :reject, -> { where(status: :reject) }
  scope :current_year, -> { where("date < ?", "#{Time.now.year}-12-31") }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true

  belongs_to :staff

  validates :date, :status, :reason, :staff, :category, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :kind, in: [:whole_day, :morning, :afternoon], default: :whole_day
  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end

end
