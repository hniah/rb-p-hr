require 'rails_helper'

describe Admin do
  context 'validations' do
    it { should validate_acceptance_of :is_admin }
  end
end
