FactoryGirl.define do
  factory :leave do
    category :unpaid

    reason 'Sickly'
    status :approved
    staff

    trait :with_leave_days do
      after(:create) do |leave|
        create_list :leave_day, 3, leave: leave
      end
    end
  end
end
