require 'rails_helper'

describe Setting do
  context 'validations' do
    it { is_expected.to validate_presence_of :key }
  end
end
