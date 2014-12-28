require 'rails_helper'

describe 'View Settings List' do
  let!(:settings) { create_list :setting, 5 }

  context 'When admin logged in' do
    let(:admin) { create(:admin) }

    it 'shows all settings' do
      feature_login(admin)

      visit root_path

      click_on 'Setting'

      expect(page).to have_content 'List of Settings'
      expect(page.all('tr').count).to eql(6)
    end
  end
end
