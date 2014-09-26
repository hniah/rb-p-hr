require 'rails_helper'

describe 'Admin edit setting' do
  let(:admin) { create :admin }
  let!(:settings) { create_list :setting, 3 }
  let(:setting) { settings.first }

  before { login_as admin }

  it 'displays edit setting form' do
    visit root_path
    click_on 'Setting'
    get_element("edit-setting-#{setting.id}").click

    fill_in 'Key', with: 'EMAIL_DEFAULT_FROM'
    fill_in 'Value', with: 'mailer@futureworkz.com'
    click_on 'Update Setting'

    expect(page).to have_content 'Settings List'
    expect(page).to have_content 'EMAIL_DEFAULT_FROM'
    expect(page).to have_content 'Setting is successfully updated'
  end
end
