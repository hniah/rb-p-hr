require 'rails_helper'

describe 'Delete user' do
  let!(:users) { create_list(:user, 5) }
  let(:user) { users.first }
  let(:admin) { create :admin }

  it 'Delete user' do
    feature_login admin
    visit admin_staffs_path

    get_element("delete-staff-#{user.id}").click

    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Staff is successfully deleted.'
  end
end
