FactoryGirl.define do
  factory :leave do
    category :unpaid

    reason 'Sickly'
    status :approved
    staff
  end
end
