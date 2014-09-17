class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(id: :desc) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }
  scope :pending, -> { where(status: :pending) }
  scope :in_year,  -> (year) { where("DATE_PART('year', start_day) = :year AND DATE_PART('year', end_day) = :year", {year: year} )}
  scope :current_year, -> { in_year(Time.now.year) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true

  attr_accessor :start_time, :end_time, :total_value

  belongs_to :staff

  validates :status, :reason, :staff, :category, :start_day, :end_day, :total, presence: true
  validates :staff_id, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?} }
  validate :end_day_greater_than_start_day

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

  after_initialize :assigns_default_values

  def total_value
    -1 * self.total.to_f if total.present?
  end

  def total_value=(value)
    self.total = -1.0 * value.to_f
  end

  def start_time
    @start = self.start_day.strftime('%y %m %d %H:%M')
    @start.split(' ')[3]
  end

  def end_time
    @end = self.end_day.strftime('%y %m %d %H:%M')
    @end.split(' ')[3]
  end

  def assigns_default_values
    self.start_day ||= Date.today
    self.end_day ||= Date.today
    self.total_value ||= 0.0
  end

  def self.kind_options_start
    [['8:30', '8:30'], ['12:00', '12:00']]
  end

  def self.kind_options_end
    [['12:00', '12:00'], ['17:30', '17:30']]
  end

  def end_day_greater_than_start_day
    if end_day < start_day
      errors.add(:end_day, 'End Day is greater than Start Day')
    end
  end
end
