require 'rails_helper'

describe Staff do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :english_name }
    it { is_expected.to validate_presence_of :personal_email }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :phone_number }
    it { is_expected.to validate_presence_of :basic_salary }
    it { is_expected.to validate_presence_of :started_on }
    it { is_expected.to validate_presence_of :probation_end_on }
  end

  context 'validation email'  do
    let(:staff){ build(:staff) }

    it 'validates email address' do
      staff.email = 'martin@futureworkz.com'
      expect(staff.valid?).to be_truthy
      staff.email = 'martin124@gmail.com'
      expect(staff.valid?).to be_falsey
      staff.email = 'martin.com'
      expect(staff.valid?).to be_falsey
    end
  end

  context 'validation personal email' do
    let(:staff){ build(:staff) }

    it 'validates email address' do
      staff.personal_email = 'vuquangthang87@gmail.com'
      expect(staff.valid?).to be_truthy
      staff.personal_email = 'martin.com'
      expect(staff.valid?).to be_falsey
    end
  end

end
