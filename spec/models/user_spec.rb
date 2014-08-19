require 'rails_helper'

describe User do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :english_name }
    it { is_expected.to validate_presence_of :personal_email }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :phone_number }
    it { is_expected.to validate_presence_of :basic_salary }
    it { is_expected.to validate_presence_of :started_on }
    it { is_expected.to validate_presence_of :probation_end_on }
    it { is_expected.to validate_numericality_of(:phone_number) }
  end

  context 'validation email'  do
    let(:user){ build(:user) }

    it 'validates email address' do
      user.email = 'martin@futureworkz.com'
      expect(user.valid?).to be_truthy
      user.email = 'martin124@gmail.com'
      expect(user.valid?).to be_falsey
      user.email = 'martin.com'
      expect(user.valid?).to be_falsey
    end
  end

  context 'validation personal email' do
    let(:user){ build(:user) }

    it 'validates email address' do
      user.personal_email = 'vuquangthang87@gmail.com'
      expect(user.valid?).to be_truthy
      user.personal_email = 'martin.com'
      expect(user.valid?).to be_falsey
    end
  end

end
