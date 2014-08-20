require 'rails_helper'

describe Staff do
  context 'associations' do
    it { should have_many :leaves }
  end
end
