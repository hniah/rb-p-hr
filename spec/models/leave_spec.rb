require 'rails_helper'

describe Leave do
  context 'validations' do
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :reason }
    it { is_expected.to validate_presence_of :staff }
    it { is_expected.to validate_presence_of :staff_id }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :total }
    it { is_expected.to enumerize(:status).in(:pending, :approved, :rejected) }
    it { is_expected.to enumerize(:category).in(:unpaid, :sick, :annual, :compassionate, :maternity, :urgent) }
  end

  context 'associations' do
    it { should belong_to :staff }
  end

  context 'validations note when status is reject' do
    let!(:leave) { build(:leave, status: :rejected, rejection_note: '') }

    it 'validations reason when status is un-worked' do
      expect(leave.valid?).to eq false
    end
  end


  context '#total_leave_days' do
    let(:leave) { create :leave, start_day: '16/09/2014 8:30', end_day: '16/09/2014 17:30' }

    it 'returns total leave days of leave if start day equal end day' do
      expect(leave.calculate_total).to eq 1
    end
  end

  describe 'returns total leave days of leave if start day difference end day' do
    context '#total_leave_days' do
      let(:leave) { create :leave, start_day: '19/09/2014 8:30', end_day: '22/09/2014 12:00' }

      it 'returns total leave days of leave if start day difference end day' do
        expect(leave.calculate_total).to eq 1.5
      end
    end
  end

  describe 'returns total leave days of leave if start day difference end day' do
    context '#total_leave_days' do
      let(:leave) { create :leave, start_day: '19/09/2014 8:30', end_day: '22/09/2014 12:00' }

      it 'returns total leave days of leave if start day difference end day' do
        expect(leave.calculate_total).to eq 1.5
      end
    end
  end

  describe 'returns total leave days of leave if start day difference end day' do
    context '#total_leave_days' do
      let(:leave) { create :leave, start_day: '19/09/2014 8:30', end_day: '23/09/2014 17:30' }

      it 'returns total leave days of leave if start day difference end day' do
        expect(leave.calculate_total).to eq 3
      end
    end
  end

  describe 'get data in current year' do
    context 'get data in current year' do
      let!(:leave_current_year) { create :leave, start_day: '2014-09-16', end_day: '2014-09-16'}
      let!(:leave_last_year) { create :leave, start_day: '2013-09-16', end_day: '2013-09-16'}

      it 'get data in current year' do
        expect(Leave.current_year.count).to eq 1
      end
    end

  end

end
