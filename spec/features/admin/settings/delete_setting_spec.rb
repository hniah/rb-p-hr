require 'rails_helper'

describe 'Admin delete setting' do
  let(:admin) { create :admin }
  let!(:settings) { create_list :setting, 3 }
  let(:setting) { settings.first }

  before { login_as admin }

  it 'displays list of settings' do
    visit root_path
    click_on 'Setting'
    get_element("delete-setting-#{setting.id}").click

    expect(page).to have_content 'Setting is successfully deleted'
  end
end
