require 'rails_helper'

describe Staff do
  context 'associations' do
    it { is_expected.to have_many :leaves }
    it { is_expected.to have_many :feedbacks }
    it { is_expected.to have_many :lates }
  end

  context 'validations' do
    let(:jack) { create :staff }
    let!(:exceeding_late) { jack.lates.new }

    before { jack.lates << create_list(:late, 10) }

    it 'makes sure that staff cannot have more than one lates' do
      expect(jack).to_not be_valid
    end
  end

  context '#total_leave_days_in_this_year' do
    let(:staff) { create :staff }
    let(:leave_days_this_year) { create_list :leave_day, 3, date: '2014-08-09'}
    let(:leave_days_last_year) { create_list :leave_day, 3, date: '2013-08-09'}
    let(:leave_this_year) { create :leave, status: :approved, leave_days: leave_days_this_year }
    let(:leave_last_year) { create :leave, status: :approved, leave_days: leave_days_last_year }

    before { staff.leaves << leave_this_year }
    before { staff.leaves << leave_last_year }

    it 'calculator total leave days in this year' do
      expect(staff.total_leave_days_in_this_year).to eq 3
    end
  end
end

