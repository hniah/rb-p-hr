FactoryGirl.define do
  factory :leave do
    category :unpaid
    sequence :date do |n|
      "20#{n}-08-05"
    end
    kind :whole_day

    reason 'Sickly'
    status :approved
    staff
  end
end
