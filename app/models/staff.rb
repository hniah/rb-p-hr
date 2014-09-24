class Staff < User

  scope :to_options, -> { all.collect { |staff| [ staff.english_name, staff.id ] } }

  has_many :leaves
  has_many :lates
  has_many :feedbacks
  has_many :leave_days, through: :leaves

  def remaining_leave_days(year)
    self.leaves.in_year(year).annual.approved.sum(:total)
  end
end
