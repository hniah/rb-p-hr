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

  describe '#total_leave_days_in_this_year' do
    let(:staff) { create :staff }
    let(:leave_days_this_year) { create_list :leave_day, 3, date: Date.today }
    let(:leave_days_last_year) { create_list :leave_day, 3, date: '2013-08-09' }
    let(:leave_this_year) { create :leave, status: :approved, leave_days: leave_days_this_year }
    let(:leave_last_year) { create :leave, status: :approved, leave_days: leave_days_last_year }

    before { create :leave, status: :pending, staff: staff, leave_days: create_list(:leave_day, 5, date: Date.yesterday) }
    before { staff.leaves << leave_this_year }
    before { staff.leaves << leave_last_year }

    it 'calculates total leave days in this year of the staff' do
      expect(staff.total_leave_days_in_this_year).to eq 3
    end
  end

  describe '#cumulative_leaves' do
    let(:staff) { create :staff }
    let(:leave_days_last_year) { create_list :leave_day, 3, date: '2013-08-09' }
    let(:leave_last_year) { create :leave, status: :approved, leave_days: leave_days_last_year }

    before { staff.leaves << leave_last_year }

    it 'calculates total leave days in this year of the staff' do
      expect(staff.cumulative_leaves).to eq 7
    end
  end

  describe '#remaining_leave_days' do
    let(:staff) { create :staff }
    let(:leave_days_this_year) { create_list :leave_day, 3, date: Date.today }
    let(:leave_days_last_year) { create_list :leave_day, 12, date: '2013-08-09' }
    let(:leave_this_year) { create :leave, status: :approved, leave_days: leave_days_this_year }
    let(:leave_last_year) { create :leave, status: :approved, leave_days: leave_days_last_year }

    before { create :leave, status: :pending, staff: staff, leave_days: create_list(:leave_day, 5, date: Date.yesterday) }
    before { staff.leaves << leave_this_year }
    before { staff.leaves << leave_last_year }

    it 'calculates total leave days in this year of the staff' do
      expect(staff.remaining_leave_days).to eq 13
    end
  end
end

