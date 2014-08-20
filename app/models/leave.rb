class Leave < ActiveRecord::Base
  extend Enumerize

  delegate :english_name, to: :staff, prefix: true, allow_nil: true

  belongs_to :staff

  validates :date, :status, :staff, presence: true
  validates :note, presence: {if: -> {status.present? && status.reject?}}

  enumerize :kind, in: [:whole_day, :morning, :afternoon], default: :whole_day
  enumerize :status, in: [:approve, :reject], default: :approve

  def assigns_default_values
    self.date ||= Date.today
  end

end
