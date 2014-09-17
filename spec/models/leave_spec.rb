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

  describe '#total' do
    let(:leave) { build(:leave) }

    it 'validates total based on total_value' do
      leave.total_value = 10
      expect(leave.total).to eq -10
      expect(leave).to be_valid
    end
  end

  describe 'validations note when status is reject' do
    context 'validations note when status is reject' do
      let!(:leave) { build(:leave, status: :rejected, rejection_note: '') }

      it 'validations rejection note when status is reject' do
        expect(leave.valid?).to eq false
      end
    end
  end

  describe 'validations end day when start day is lower end day' do
    let!(:leave) { build(:leave, start_day: '2014-09-17', end_day: '2014-08-17')}

    context 'validations end day when start day is lower end day' do
      it 'validations end day when start day is lower end day' do
        expect(leave.valid?).to eq false
      end
    end
  end
end
