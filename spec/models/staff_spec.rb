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

  describe '#remaining_leave_days' do
    let!(:martin) { create :staff }
    let!(:total_leave_in_year) { create :leave, start_day: '2014-01-01 8:30', end_day: '2014-12-31 17:30', total: 14, staff: martin}
    let!(:leaves_current_year) { create_list :leave, 2, start_day: '2014-09-16 8:30', end_day: '2014-09-18 17:30', total: -3.0, staff: martin}
    let!(:leaves_last_year) { create_list :leave, 2, start_day: '2013-09-16 8:30', end_day: '2013-09-18 17:30', total: -3.0, staff: martin}

    context 'calculator remaining leave days for staff' do
      it 'calculator remaining leave days for staff' do
        expect(martin.remaining_leave_days).to eq 8
      end
    end
  end
end
