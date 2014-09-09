FactoryGirl.define do
  factory :setting do
    sequence :key do |n|
      "admin_password_#{n+rand(5..99999)}"
    end
    value '123456'
  end
end
