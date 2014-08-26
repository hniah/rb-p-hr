class LeaveDay < ActiveRecord::Base
  extend Enumerize

  scope :in_year,  -> (year) { where("DATE_PART('year', date) = ?", year)}
  scope :current_year, -> { in_year(Time.now.year) }
  scope :whole_day, -> { where(kind: :whole_day) }
  scope :half_day, -> { where("kind = 'morning' OR kind = 'afternoon'") }
  scope :to_sentence, -> { pluck(:date).to_sentence }
  scope :with_leave, -> { includes(:leave) }

  belongs_to :leave

  validates :date, :kind, presence: true

  enumerize :kind, in: [:whole_day, :morning, :afternoon], default: :whole_day

  after_initialize :assigns_default_values

  def assigns_default_values
    self.date ||= Date.today
  end

  def calculated_as
    return 0 unless approved?
    self.kind.whole_day? ? 1.0 : 0.5 if approved?
  end

  def approved?
    self.leave.status.approved?
  end
end
