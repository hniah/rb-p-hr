# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'Start seeding admin'

admins_data = [
  { name: 'Vu Quang Thang', english_name: 'Martin', email: 'martin@futureworkz.com', personal_email: 'vuquangthang87@gmail.com', address: 'Viet Nam', phone_number: '0123213123', basic_salary: '123', started_on: '2012/06/16', probation_end_on: '2012/08/16', designation: 'Coder' },
  { name: 'Emily', english_name: 'Emily', email: 'emily@futureworkz.com', personal_email: 'emily@gmail.com', address: 'Viet Nam', phone_number: '034543534', basic_salary: '223', started_on: '2014/06/16', probation_end_on: '2014/08/16', designation: 'HR' }

]

admins_data.each do |admin_data|
  admin = Staff.find_or_initialize_by(admin_data)
  admin.password = '123456789'
  admin.is_admin = true
  admin.save
end

puts 'Admin seeded'
