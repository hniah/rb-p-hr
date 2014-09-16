class Leave < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(id: :desc) }
  scope :approved, -> { where(status: :approved) }
  scope :rejected, -> { where(status: :rejected) }
  scope :pending, -> { where(status: :pending) }

  delegate :id, :english_name, :email, to: :staff, prefix: true, allow_nil: true

  attr_accessor :start_time, :end_time

  belongs_to :staff

  validates :status, :reason, :staff, :category, :start, :end, :total, presence: true
  validates :staff_id, presence: true
  validates :rejection_note, presence: {if: -> {status.present? && status.rejected?}}

  enumerize :status, in: [:pending, :approved, :rejected], default: :pending
  enumerize :category, in: [:unpaid, :sick, :annual, :compassionate, :maternity, :urgent], default: :annual

  has_paper_trail class_name: 'Version', ignore: [:updated_at, :created_at]

  after_initialize :assigns_default_values

  def start_time
    @start = self.start.strftime('%y %m %d %H:%M')
    @start.split(' ')[3]
  end

  def end_time
    @end = self.end.strftime('%y %m %d %H:%M')
    @end.split(' ')[3]
  end

  def assigns_default_values
    self.start ||= Date.today
    self.end ||= Date.today
  end

  def self.kind_options_start
    [['8:30', '8:30'], ['12:00', '12:00']]
  end

  def self.kind_options_end
    [['12:00', '12:00'], ['17:30', '17:30']]
  end

  def calculate_total
    total_days = total_days()

    @start = Time.parse(self.start.strftime('%B %d, %Y %H:%M'))
    @end   = Time.parse(self.end.strftime('%B %d, %Y %H:%M'))

    if @start.to_date == @end.to_date
      total_seconds = @end - @start
    else
      end_of_workday = Time.end_of_workday(@start)
      end_of_workday += 1 if end_of_workday.to_s =~ /23:59:59/

      first_day       = end_of_workday - @start
      days_in_between = ((@start.to_date + 1)..(@end.to_date - 1)).sum{ |day| Time::work_hours_total(day) }
      last_day     = @end - Time.beginning_of_workday(@end)

      total_seconds = first_day + days_in_between + last_day - (total_days*3600)
    end
    if (self.end.strftime('%H:%M') == '17:30')
      total_seconds -= 3600
    end
    (total_seconds / 3600).ceil.to_f / 8
  end

  protected
  def total_days
    @start = Date.parse(self.start.strftime('%B %d, %Y'))
    @end   = Date.parse(self.end.strftime('%B %d, %Y'))
    @start.business_days_until(@end)
  end
end
