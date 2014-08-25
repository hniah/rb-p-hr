FactoryGirl.define do
  factory :leave_day do
    sequence :date do |n|
      "20#{n}-08-05"
    end
    kind :whole_day

  end
end
