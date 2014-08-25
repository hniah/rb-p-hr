class LeaveDay < ActiveRecord::Base
  extend Enumerize

  scope :current_year, -> { where("date < ?", "#{Time.now.year}-12-31") }
  scope :whole_day, -> { where(kind: :whole_day) }
  scope :half_day, -> { where("kind = 'morning' OR kind = 'afternoon'") }

  belongs_to :leave

  validates :date, :kind, presence: true

  enumerize :kind, in: [:whole_day, :morning, :afternoon], default: :whole_day

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end
end
