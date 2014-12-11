class Staff < User

  scope :to_options, -> { all.collect { |staff| [ staff.english_name, staff.id ] } }
  scope :emails_cc, -> { all.collect { |staff| [ staff.english_name, staff.email ] } }
  scope :emails_cc_exclude, -> (staff_id) { where('id NOT IN (:staff_id)', {staff_id: staff_id}).collect { |staff| [ staff.english_name, staff.email ] } }
  scope :leaders, -> { where(is_leader: :true) }

  has_many :leaves
  has_many :lates
  has_many :feedbacks
  has_many :leave_days, through: :leaves

  def remaining_leave_days(year)
    self.leaves.in_year(year).annual.approved.sum(:total)
  end

  def remaining_sick_days(year)
    self.leaves.in_year(year).sick.approved.sum(:total)
  end
  
end
