require 'rails_helper'

describe LeaveDay do
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :kind }
  it { is_expected.to enumerize(:kind).in(:whole_day, :morning, :afternoon) }

  context 'associations' do
    it { should belong_to :leave }
  end

end
