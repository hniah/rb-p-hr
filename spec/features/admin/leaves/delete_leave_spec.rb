require 'rails_helper'

describe 'Delete Leave' do
  let(:admin) { create :admin }
  let!(:leave) { create :leave, :with_leave_days, status: :pending }

  it 'Delete Leave' do
    feature_login admin

    visit admin_leaves_path

    get_element("delete-leave-#{leave.id}").click

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content 'Leave is successfully deleted.'
  end
end
