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

  context 'calculated_as' do
    let(:leave_day) { create :leave_day, date: '2013-03-03', kind: :morning }

    it 'calculated as leave a haft day' do
      expect(leave_day.calculated_as).to eq 0.5
    end
  end

  context 'calculated_as' do
    let(:leave_day) { create :leave_day, date: '2013-03-03', kind: :whole_day }

    it 'calculated as leave whole day' do
      expect(leave_day.calculated_as).to eq 1.0
    end
  end

end
