require 'rails_helper'

describe 'Display add setting form' do
  let(:admin) { create :admin }
  let!(:settings) { create_list :setting, 3 }

  before { login_as admin }

  it 'saves the setting', js: true do
    visit root_path

    click_on 'Setting'
    click_on 'Add new'

    get_element("fill-in-key").set('email_notifier')
    get_element("fill-in-value").set('martin@futureworkz.com')
    click_on 'Create Setting'

    expect(page).to have_content 'List of Settings'
    expect(page).to have_content 'Setting is successfully created.'
    expect(page).to have_content 'email_notifier'
  end
end
