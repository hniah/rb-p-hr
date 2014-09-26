require 'rails_helper'

describe 'Log in with Google account' do

  context 'User has an account' do
    before { create :admin, email: 'martin@futureworkz.com' }

    it 'logs admin in' do
      visit root_path

      click_on 'Sign in with Google'

      expect(page).to have_content 'Successfully authenticated from Google account'
    end
  end

  context "User doesn't have an account" do
    before { create :admin, email: 'test@futureworkz.com' }

    it 'does not allow him to login in' do
      visit root_path

      click_on 'Sign in with Google'

      expect(page).to have_content 'Could not authenticate you from Google.'
    end
  end
end
