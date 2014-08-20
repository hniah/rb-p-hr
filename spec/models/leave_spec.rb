require 'rails_helper'

describe Leave do
  context 'validations' do
    it { is_expected.to validate_presence_of :date }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :staff }
    it { is_expected.to validate_presence_of :types }
    it { is_expected.to enumerize(:status).in(:pending, :approve, :reject) }
    it { is_expected.to enumerize(:kind).in(:whole_day, :morning, :afternoon) }
    it { is_expected.to enumerize(:types).in(:unpaid, :sick, :annual, :compassionate, :maternity, :urgent) }
  end

  context 'associations' do
    it { should belong_to :staff }
  end

  context 'validations note when status is reject' do
    let!(:leave) { build(:leave, status: :reject, note: '') }

    it 'validations reason when status is un-worked' do
      expect(leave.valid?).to eq false
    end
  end
end
