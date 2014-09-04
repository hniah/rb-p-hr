class Staff < User

  scope :to_options, -> { all.collect { |staff| [ staff.name, staff.id ] } }

  LEAVE_DAYS = 14.0
  MAX_CUMULATIVE_LEAVE_DAYS = 7.0

  has_many :leaves
  has_many :lates
  has_many :feedbacks
  has_many :leave_days, through: :leaves

  validates :lates, length: {maximum: 10, message: 'Staff cannot have more than 10 leaves. Send him a warning letter.'}

  def remaining_leave_days_in(current_year)
    LEAVE_DAYS + self.cumulative_leaves - total_leave_days_in(current_year)
  end

  def total_leave_days_in(year)
    self.leave_days.in_year(year).with_leave.collect do |leave_day|
      leave_day.calculated_as
    end.sum
  end
end
