require 'rails_helper'

describe Staff do
  context 'associations' do
    it { is_expected.to have_many :leaves }
    it { is_expected.to have_many :feedbacks }
    it { is_expected.to have_many :lates }
  end

  describe '#remaining_leave_days' do
    let!(:martin) { create :staff }
    let!(:total_leave_in_year) { create :leave, category: :annual, start_day: '2014-01-01 8:30', end_day: '2014-12-31 17:30', total: 14, staff: martin }
    let!(:leaves_current_year) { create_list :leave, 2, category: :annual, start_day: '2014-09-16 8:30', end_day: '2014-09-18 17:30', total: -3.0, staff: martin }

    context 'calculator remaining leave days for staff' do
      it 'calculator remaining leave days for staff' do
        expect(martin.remaining_leave_days(Time.now.year)).to eq 8
      end
    end
  end

  describe '#remaining_sick_days' do
    let!(:martin) { create :staff }
    let!(:total_leave_in_year) { create :leave, category: :sick, start_day: '2014-01-01 8:30', end_day: '2014-12-31 17:30', total: 14, staff: martin }
    let!(:leaves_current_year) { create_list :leave, 2, category: :sick, start_day: '2014-01-01 8:30', end_day: '2014-12-31 17:30', total: -3.0, staff: martin }
    it 'calculator remaining sick leave days for staff' do
      expect(martin.remaining_sick_days(Time.now.year)).to eq 8
    end
  end

  describe '#leader_or_not' do
    let!(:jack) { create :staff, is_leader: true, english_name: 'Jack' }
    let(:john) { build :staff }

    it 'validations staff' do
      john.english_name = 'John'
      john.is_leader = true
      john.leader = jack.id
      expect(john).not_to be_valid

      john.is_leader = false
      john.leader = jack.id
      expect(john).to be_valid
    end
  end
end
