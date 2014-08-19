require 'rails_helper'

describe 'Display Edit form' do
  let!(:users) { create_list(:user, 2) }
  let(:user) { User.first }

  it 'Display edit form' do

    visit users_path

    get_element("edit-user-#{user.id}").click

    fill_in 'Name', with: 'Martin Martin'
    fill_in 'Email', with: 'martin123@futureworkz.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Submit'

    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Staff is updated'
  end
end
