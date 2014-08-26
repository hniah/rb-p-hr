class Staff < User
  has_many :leaves
  has_many :lates
  has_many :feedbacks

  has_many :leave_days, through: :leaves

  validates :lates, length: {maximum: 10, message: 'Staff cannot have more than 10 leaves. Send him a warning letter.'}

  scope :to_options, -> { all.collect { |staff| [ staff.name, staff.id ] } }

  def total_leave_days_in_this_year
    leave_days.current_year.collect { |leave_day| leave_day.calculated_as }.sum
  end

end

