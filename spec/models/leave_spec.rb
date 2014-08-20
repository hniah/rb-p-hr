require 'rails_helper'

describe Leave do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :status }
    it { should validate_presence_of :staff }
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
