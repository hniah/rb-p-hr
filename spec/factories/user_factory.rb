FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "martin#{n}@futureworkz.com"
    end

    password '123123123'
    name 'Vu Quang Thang'
    sequence :english_name do |n|
      "Martin#{n}"
    end
    personal_email 'vuquangthang87@gmail.com'
    address 'Viet name'
    birthday '20/06/1987'
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
      is_leader false

      trait :with_lates do
        ignore do
          number_of_lates 2
        end

        after(:create) do |staff, evaluator|
          create_list :late, evaluator.number_of_lates, staff: staff
        end
      end
    end
  end
end
