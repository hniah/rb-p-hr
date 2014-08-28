require 'rails_helper'

describe 'Display note to reject Leave' do
  let(:admin) { create(:admin) }
  let!(:staff) { create(:staff) }
  let!(:leave) { create(:leave, :with_leave_days, status: :pending, staff: staff) }
  before{ create :staff }

  it 'Display note to admin inputs and reject leave' do
    feature_login admin
    visit root_path
    visit admin_leaves_path

    get_element("reject-leave-#{leave.id}").click

    fill_in 'Rejection note', with: 'Not approved by your leader'
    click_on 'Reject Leave'

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content I18n.t('leave.message.reject_leave')
    expect(page.all('tr').count).to eql(1)
  end
end
