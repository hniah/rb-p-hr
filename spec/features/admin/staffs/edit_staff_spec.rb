require 'rails_helper'

describe 'Display Edit form' do
  let!(:staffs) { create_list(:staff, 2) }
  let(:staff) { staffs.first }
  let(:admin) { create :admin }

  it 'Display edit form' do
    feature_login admin
    visit root_path

    visit admin_staffs_path

    get_element("edit-staff-#{staff.id}").click

    fill_in 'Name', with: 'Vu Quang Thang'
    fill_in 'English name', with: 'Martin Martin'
    fill_in 'Email', with: 'martin123@futureworkz.com'
    fill_in 'Personal email', with: 'vuquangthang87@gmail.com'
    fill_in 'Birthday', with: '20/07/1987'
    fill_in 'Address', with: 'Lorem ipsum Lorem ipsum'
    fill_in 'Phone number', with: '012344567'
    fill_in 'Started on', with: '20/09/02014'
    fill_in 'Probation end on', with: '20/09/02014'
    fill_in 'Note', with: 'Lorem lorem'
    click_on 'Update Staff'


    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Staff is updated'
    expect(page).to have_content 'martin123@futureworkz.com'
    expect(page).to have_content 'Martin Martin'
  end
end
