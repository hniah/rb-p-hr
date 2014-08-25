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
end

