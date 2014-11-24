FactoryGirl.define do
  factory :leave do
    category :unpaid
    leader :none
    reason 'Sickly'
    status :approved
    total -1.0
    staff
  end
end
