FactoryGirl.define do
  factory :setting do
    sequence :key do |n|
      "admin_password_#{n+rand(5..99999)}"
    end
    value '123456'
  end

  factory :EMAIL_DEFAULT_FROM do
    key 'EMAIL_DEFAULT_FROM'
    value 'mailer@futureworkz.com'
  end
end
