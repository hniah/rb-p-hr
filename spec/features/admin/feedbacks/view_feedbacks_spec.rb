require 'rails_helper'

describe 'View Feedbacks List' do
  let!(:admin) { create(:admin) }
  let!(:feedback) { create_list(:feedback, 5) }
  context 'Admin logged in' do
    it 'fetches all feedbacks and renders index view' do
      feature_login admin

      visit root_path

      click_on 'Feedbacks List'
      expect(page).to have_content 'Feedbacks List'
      expect(page.all('tr').count).to eql(6)
    end
  end
end
