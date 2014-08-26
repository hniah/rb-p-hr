class Staff < User

  scope :to_options, -> { all.collect { |staff| [ staff.name, staff.id ] } }

  has_many :leaves
  has_many :lates
  has_many :feedbacks
  has_many :leave_days, through: :leaves

  validates :lates, length: {maximum: 10, message: 'Staff cannot have more than 10 leaves. Send him a warning letter.'}

  def total_leave_days_in_this_year
    self.leave_days.current_year.with_leave.collect do |leave_day|
      leave_day.calculated_as
    end.sum
  end

  def remaining_leave_days
    14 - total_leave_days_in_this_year + cumulative_leaves
  end

  def cumulative_leaves
    total = self.leave_days.in_year(1.year.ago.year).with_leave.collect do |leave_day|
      leave_day.calculated_as
    end.sum
    total = 14 - total
    [7, total].min
  end
end

