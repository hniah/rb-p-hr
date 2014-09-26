require 'rails_helper'

describe 'Display note to reject Leave' do
  let(:admin) { create(:admin) }
  let!(:staff) { create(:staff) }
  let!(:leave) { create(:leave, status: :pending, staff: staff) }
  before{ create :staff }

  it 'Display note to admin inputs and reject leave' do
    feature_login admin
    visit root_path
    visit admin_leaves_path

    get_element("reject-leave-#{leave.id}").click

    fill_in 'Rejection note', with: 'Not approved by your leader'
    click_on 'Reject Leave'

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content 'Leave is rejected.'
    expect(page.all('tr').count).to eql(2)
  end
end
