require 'rails_helper'

describe User do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :english_name }
    it { is_expected.to validate_presence_of :personal_email }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :started_on }
    it { is_expected.to validate_presence_of :probation_end_on }
    it { is_expected.to validate_presence_of :designation }
    it { is_expected.to validate_numericality_of(:cumulative_leaves).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:cumulative_leaves).is_less_than_or_equal_to(7) }
  end

  context 'validation email'  do
    let(:user){ build(:user) }

    it 'validates email address' do
      user.email = 'martin@futureworkz.com'
      expect(user).to be_valid
      user.email = 'martin124@gmail.com'
      expect(user).not_to be_valid
      user.email = 'martin.com'
      expect(user).not_to be_valid
    end
  end

  context 'validation personal email' do
    let(:user){ build(:user) }

    it 'validates personal email' do
      user.personal_email = 'vuquangthang87@gmail.com'
      expect(user).to be_valid
      user.personal_email = 'martin.com'
      expect(user).not_to be_valid
    end
  end
end
