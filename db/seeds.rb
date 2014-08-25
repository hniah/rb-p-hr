# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Start seeding admin'

admins_data = [
  { name: 'Human Resources', english_name: 'Human Resources', email: 'hr@futureworkz.com', personal_email: 'hr@futureworkz.com', address: 'Singapore'}
]

admins_data.each do |admin_data|
  admin = Staff.find_or_initialize_by(admin_data)
  admin.password = Random.rand(10000000..99999999999999)
  admin.is_admin = true
  admin.designation = 'HR'
  admin.phone_number = '000000000'
  admin.started_on = Date.today
  admin.probation_end_on = Date.today
  admin.save!
end

puts 'Admin seeded'
