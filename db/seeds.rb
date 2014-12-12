puts '--- Start seeding sick leaves for all staff'
Staff.all.each do |staff|
  staff.leaves.new(
    category: :sick, 
    total: 7,
    reason: 'Add 7 sick leave',
    status: :approved,
    start_day: Date.today.change(month: 2),
    end_day: Date.today.change(month: 2)
  ).save!
end
