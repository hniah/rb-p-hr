require 'rails_helper'

describe 'Delete user' do
  let!(:staffs) { create_list(:staff, 5) }
  let(:staff) { staffs.first }
  it 'Delete user' do
    visit staffs_path

    get_element("delete-staff-#{staff.id}").click

    expect(page).to have_content 'Staff List'
    expect(page).to have_content I18n.t('staff.message.delete_success')
  end
end
