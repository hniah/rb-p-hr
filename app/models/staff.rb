class Staff < User

  scope :to_options, -> { all.collect { |staff| [ staff.english_name, staff.id ] } }

  has_many :leaves
  has_many :lates
  has_many :feedbacks
  has_many :leave_days, through: :leaves

  validates :lates, length: {maximum: 10, message: 'Staff cannot have more than 10 leaves. Send him a warning letter.'}

  def remaining_leave_days
    self.leaves.current_year.approved.sum(:total)
  end

end
