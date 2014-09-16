class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(id: :desc) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }
  scope :pending, -> { where(status: :pending) }
  scope :in_year,  -> (year) { where("DATE_PART('year', start_day) = :year AND DATE_PART('year', end_day) = :year", {year: year} )}
  scope :current_year, -> { in_year(Time.now.year) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true

  attr_accessor :start_time, :end_time

  belongs_to :staff

  validates :status, :reason, :staff, :category, :start_day, :end_day, :total, presence: true
  validates :staff_id, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

  after_initialize :assigns_default_values

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
  end

  def self.kind_options_start
    [['8:30', '8:30'], ['12:00', '12:00']]
  end

  def self.kind_options_end
    [['12:00', '12:00'], ['17:30', '17:30']]
  end

  def calculate_total
    total_days = total_days()

    @start_day = Time.parse(self.start_day.strftime('%B %d, %Y %H:%M'))
    @end_day   = Time.parse(self.end_day.strftime('%B %d, %Y %H:%M'))

    if @start_day.to_date == @end_day.to_date
      total_seconds = @end_day - @start_day
    else
      end_of_workday = Time.end_of_workday(@start_day)
      end_of_workday += 1 if end_of_workday.to_s =~ /23:59:59/

      first_day       = end_of_workday - @start_day
      days_in_between = ((@start_day.to_date + 1)..(@end_day.to_date - 1)).sum{ |day| Time::work_hours_total(day) }
      last_day     = @end_day - Time.beginning_of_workday(@end_day)

      total_seconds = first_day + days_in_between + last_day - (total_days*3600)
    end
    if (self.end_day.strftime('%H:%M') == '17:30')
      total_seconds -= 3600
    end
    (total_seconds / 3600).ceil.to_f / 8
  end

  protected
  def total_days
    @start_day = Date.parse(self.start_day.strftime('%B %d, %Y'))
    @end_day   = Date.parse(self.end_day.strftime('%B %d, %Y'))
    @start_day.business_days_until(@end_day)
  end
end
