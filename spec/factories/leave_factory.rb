FactoryGirl.define do
  factory :leave do
    sequence :date do |n|
      "05/08/20#{n}"
    end
    kind :whole_day
    reason_leave 'Sickly'
    status :approve
    staff
  end
end
