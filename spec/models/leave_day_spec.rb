require 'rails_helper'

describe LeaveDay do
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :kind }
  it { is_expected.to enumerize(:kind).in(:whole_day, :morning, :afternoon) }

  context 'associations' do
    it { should belong_to :leave }
  end

  context 'get data in current year' do
    let!(:leave_days) { create_list :leave_day, 1, date: '2014-03-20'}
    let!(:leave_day) { create :leave_day, date: '2013-03-03' }

    it 'get data in current year' do
      expect(LeaveDay.current_year.count).to eq 1
    end
  end

  context 'get data in year' do
    let!(:leave_days) { create_list :leave_day, 2, date: '2014-03-20'}
    let!(:leave_day) { create :leave_day, date: '2013-03-03' }

    it 'get data in year' do
      expect(LeaveDay.in_year(Time.now.year - 1).count).to eq 1
    end
  end

  describe '#calculated_as' do
    context 'leave is approved' do
      let(:leave) { create :leave, status: :approved }

      context 'whole day leave' do
        let(:leave_day) { create :leave_day, date: '2013-03-03', kind: :whole_day, leave: leave }

        it 'calculated as one day' do
          expect(leave_day.calculated_as).to eq 1.0
        end
      end

      context 'morning leave' do
        let(:leave_day) { create :leave_day, date: '2013-03-03', kind: :morning, leave: leave }

        it 'calculated as half day' do
          expect(leave_day.calculated_as).to eq 0.5
        end
      end
    end

    context 'leave is rejected' do
      let(:leave) { create :leave, status: :pending }
      let(:leave_day) { create :leave_day, date: '2013-03-03', kind: :morning, leave: leave }

      it 'does not count leave days' do
        expect(leave_day.calculated_as).to eq 0
      end
    end
  end
end
