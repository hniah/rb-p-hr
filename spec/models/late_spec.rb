require 'rails_helper'

describe Late do
  context 'validations' do
    it { is_expected.to validate_presence_of :staff }
  end

  context 'associations' do
    it { is_expected.to belong_to :staff }
  end
end

