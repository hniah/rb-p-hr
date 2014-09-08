require 'rails_helper'

describe 'Display add setting form' do
  let(:admin) { create :admin }
  let!(:settings) { create_list :setting, 3 }

  before { login_as admin }

  it 'saves the setting', js: true do
    pending 'WIP - user failed to log in with Capybara webkit'
    visit root_path
    login_as admin

    click_on 'Setting'
    click_on 'Add new'

    get_element("fill-in-key").set('email_notifier')
    get_element("fill-in-value").set('martin@futureworkz.com')
    click_on 'Add'

    expect(page).to have_content 'Settings List'
    expect(page).to have_content 'Setting is successfully created.'
    expect(page).to have_content 'email_notifier'
  end
end
