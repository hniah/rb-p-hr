puts '--- Start seeding sick leaves for all staff'
Staff.all.each do |staff|
  staff.leaves.new(
    category: :sick, 
    total: 7,
    reason: 'Add 7 sick leave',
    status: :approved,
    start_date: Time.now.beginning_of_year,
    end_date: Time.now.beginning_of_year
  ).save!
end
