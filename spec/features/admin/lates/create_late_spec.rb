require 'rails_helper'

describe 'Admin can create late feature' do
  let(:admin) { create :admin }
  let(:late_staff) { attributes_for :admin }

  before { login_as admin }

  it 'saves the late then redirects user back to home page' do
    visit root_path
    click_on 'Add New Late'

    expect(page).to have_content 'Add New Late'

    fill_in 'late[date]', with: '20/08/2014'
    fill_in 'Note', with: 'This is a note'
    select admin.english_name, from: 'Staff'
    click_on 'Create Late'

    expect(page).to have_content 'Late is successfully created.'
  end
end
