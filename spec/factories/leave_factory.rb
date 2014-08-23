FactoryGirl.define do
  factory :leave do
    sequence :date do |n|
      "20#{n}-08-05"
    end
    kind :whole_day
    reason 'Sickly'
    status :approved
    types :unpaid
    staff
  end
end
