puts 'Start seeding staff'

staffs_data = [
  {name: 'Nguyen Thi Hong Trang', english_name: 'Jenifer'},
  {name: 'Tran Duc Trinh', english_name: 'Iker'},
  {name: 'Cao Khanh Hung', english_name: 'Heroman'},
  {name: 'Pham Le Huy', english_name: 'Eric'},
  {name: 'Vo Huy Binh', english_name: 'brian'},
  {name: 'Nguyen Dang Anh Khoa', english_name: 'Khoa'},
  {name: 'Quach Thi Thu Trang', english_name: 'Naomi'},
  {name: 'Bui Thi Ngoc Han', english_name: 'Wendy'},
  {name: 'Vu Quang Thang', english_name: 'Martin'},
  {name: 'Huynh Quan Cam', english_name: 'Jack'},
  {name: 'Hoang Ngoc Hai', english_name: 'Anthony'},
  {name: 'Tran Thanh Tuyen', english_name: 'Alice'},
  {name: 'Dam An Thu', english_name: 'Shane'},
  {name: 'Thai Manh Huy', english_name: 'Frank'},
  {name: 'La Hong Phat', english_name: 'James'},
  {name: 'Nguyen Trung Nghia', english_name: 'Ivan'},
  {name: 'Tran Tuan Anh', english_name: 'John'},
  {name: 'Lam Nhu Phuong', english_name: 'Teddy'},
  {name: 'Do Ngoc Anh', english_name: 'Amee'},
  {name: 'Tra Thuy Hong', english_name: 'Rosy'},
  {name: 'Tang Khanh Phu', english_name: 'Canon'},
  {name: 'Ha Le Ly Va', english_name: 'Sandy'},
  {name: 'Huynh Ngoc Xuan Diep', english_name: 'Jackie'},
  {name: 'Ho Phan Nhan Tri', english_name: 'Seika'},
  {name: 'Nguyen Quoc Trung', english_name: 'Maicon'},
  {name: 'Nguyen Thi Thao', english_name: 'Joane'},
  {name: 'Nguyen Thanh Ha Linh', english_name: 'Emily'},
  {name: 'Nguyen Thi Hoai Thu', english_name: 'Lucy'},
  {name: 'Mai Van Vu', english_name: 'Rain'},
]

staffs_data.each do |staff_data|
  staff = Staff.find_or_initialize_by(staff_data)
  staff.designation = 'Staff'
  staff.is_admin = false
  staff.password = Random.rand(100000000..9999999999999999)
  staff.email = "#{staff_data[:english_name].downcase}@futureworkz.com"
  staff.personal_email = "#{staff_data[:english_name].downcase}@futureworkz.com"
  staff.address = "Vietnam"
  staff.phone_number = "000000000000"
  staff.started_on = Date.today
  staff.probation_end_on = Date.today
  staff.save!
end

puts 'Staff seeded'
