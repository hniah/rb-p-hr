require 'rails_helper'

describe 'Staff can view his own lates' do
  let(:staff) { create :staff }
  let(:late) { staff.lates.first }
  
  before { feature_login staff }
  before { staff.lates << create_list(:late, 3) }

  it 'displays list of lates' do
    visit root_path
    get_element('my-account').click

    p page.body

    click_on 'View all your lates'

    expect(page).to have_content late.note
    expect(page.all('tr').count).to eql(4)
  end
end
