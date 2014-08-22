require 'rails_helper'

describe 'Display note to reject Leave' do
  let(:admin) { create(:admin) }
  let!(:staff) { create(:staff) }
  let!(:leave) { create(:leave, status: :pending, staff: staff) }
  before{ create :staff }

  it 'Display note to admin inputs and reject leave' do
    feature_login admin
    visit root_path
    visit leaves_path

    get_element("reject-leave-#{leave.id}").click

    fill_in 'Note', with: 'Not approved by your leader'
    click_on 'Reject Leave'

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content I18n.t('leave.message.reject_leave')
    expect(page).to have_content 'Not approved by your leader'
  end
end
