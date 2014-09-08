require 'rails_helper'

describe 'Display add setting form' do
  let(:admin) { create :admin }

  it 'saves the setting' do
    feature_login admin
    visit root_url

    click_on 'Add Setting'

    fill_in 'Key', with: 'email_notifier'
    fill_in 'Value', with: 'martin@futureworkz.com'
    click_on 'Create Setting'

    expect(page).to have_content 'Settings List'
    expect(page).to have_content 'Setting is successfully created.'
    expect(page).to have_content 'email_notifier'
  end
end
