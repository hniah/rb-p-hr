require 'rails_helper'

describe Feedback do
  context 'validations' do
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_presence_of :content }
  end

  context 'associations' do
    it { is_expected.to belong_to :staff }
  end

  context 'enumerize' do
    it { is_expected.to enumerize(:type).in(:feedback, :bug, :suggestion) }
  end
end

