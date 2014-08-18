require 'rails_helper'

describe 'Display Edit form' do
  let!(:staffs) { create_list(:staff, 2) }
  let(:staff) { Staff.first }

  it 'Display edit form' do

    visit staffs_path

    get_element("edit-staff-#{staff.id}").click

    fill_in 'Name', with: 'Martin Martin'
    fill_in 'Email', with: 'martin123@futureworkz.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Submit'

    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Staff is updated'
  end
end
