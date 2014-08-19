FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "martin#{n}@futureworkz.com"
    end

    password '123123123'
    name 'Vu Quang Thang'
    english_name 'Martin'
    personal_email 'vuquangthang87@gmail.com'
    address 'Viet name'
    phone_number '091234564'
    basic_salary '456'
    started_on '20/06/2012'
    probation_end_on '20/08/2012'
    designation 'Coder'

    factory :admin do
      is_admin true
    end

    factory :staff, class: Staff do
      is_admin false
    end
  end
end
