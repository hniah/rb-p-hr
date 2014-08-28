require 'rails_helper'

describe 'Staff can view his own lates' do
  let(:staff) { create :staff }
  let(:late) { staff.lates.first }
  
  before { feature_login staff }
  before { staff.lates << create_list(:late, 3) }

  it 'displays list of lates' do
    visit root_path
    click_on 'My Account'

    click_on 'View all my lates'

    expect(page).to have_content late.note
  end
end
