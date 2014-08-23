class Staff < User
  has_many :leaves

  scope :to_options, -> { all.collect { |staff| [ staff.name, staff.id ] } }
end
