class Leave < ActiveRecord::Base
  extend Enumerize
  default_scope -> { order(date: :desc, id: :asc) }
  scope :approve, -> { where(status: :approve) }
  scope :reject, -> { where(status: :reject) }

  delegate :english_name, to: :staff, prefix: true, allow_nil: true

  belongs_to :staff

  validates :date, :status, :staff, presence: true
  validates :note, presence: {if: -> {status.present? && status.reject?}}

  enumerize :kind, in: [:whole_day, :morning, :afternoon], default: :whole_day
  enumerize :status, in: [:pending, :approve, :reject], default: :pending

  def assigns_default_values
    self.date ||= Date.today
  end

end
