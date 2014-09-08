require 'rails_helper'

describe Setting do
  context 'validations' do
    it { is_expected.to validate_presence_of :key }
  end

  context '#.[]' do
    let!(:setting) { create :setting, key: 'email_notifier', value: 'martin@futureworkz.com' }

    it '' do
      expect(Setting['email_notifier']).to eq 'martin@futureworkz.com'
    end
  end

  context '' do
    let!(:setting) { create :setting, key: 'email_notifier_hr', value: 'hr@futureworkz.com' }

    it '' do
      expect(Setting.email_notifier_hr).to eq 'hr@futureworkz.com'
    end
  end
end
