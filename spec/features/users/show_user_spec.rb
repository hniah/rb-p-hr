require 'rails_helper'

describe 'Show staff detail' do
  context 'Show staff detail' do
    let!(:user) { create(:user) }
    let!(:admin) { create :admin }

    it 'show project detail' do
      visit root_path
      feature_login admin

      visit users_path

      get_element("view-user-#{user.id}").click

      expect(page).to have_content user.name
      expect(page).to have_content user.english_name
      expect(page).to have_content user.email
      expect(page).to have_content user.personal_email
    end
  end
end
