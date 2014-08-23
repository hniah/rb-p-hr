require 'rails_helper'

describe Feedback do
  context 'validations' do
    it { is_expected.to validate_presence_of :kind }
    it { is_expected.to validate_presence_of :content }
  end

  context 'associations' do
    it { is_expected.to belong_to :staff }
  end

  context 'enumerize' do
    it { is_expected.to enumerize(:kind).in(:feedback, :bug, :suggestion) }
  end
end

