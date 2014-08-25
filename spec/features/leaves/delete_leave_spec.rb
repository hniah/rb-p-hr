require 'rails_helper'

describe 'Delete Leave' do
  let(:admin) { create :admin }
  let!(:leave) { create :leave, :with_leave_days }

  it 'Delete Leave' do
    feature_login admin

    visit leaves_path

    get_element("delete-leave-#{leave.id}").click

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content I18n.t('leave.message.delete_success')
  end
end
