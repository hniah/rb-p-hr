FactoryGirl.define do
  factory :leave do
    category :unpaid

    reason 'Sickly'
    status :approved
    total -1.0
    staff
  end
end
