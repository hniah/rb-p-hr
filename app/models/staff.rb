class Staff < User
  has_many :leaves
  has_many :lates
  has_many :feedbacks

  validates :lates, length: {maximum: 10, message: 'Staff cannot have more than 10 leaves. Send him a warning letter.'}

  scope :to_options, -> { all.collect { |staff| [ staff.name, staff.id ] } }
end

