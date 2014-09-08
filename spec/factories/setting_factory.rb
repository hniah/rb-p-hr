FactoryGirl.define do
  factory :setting do
    sequence :key do |n|
      "admin_password_#{n}"
    end
    value '123456'
  end
end
