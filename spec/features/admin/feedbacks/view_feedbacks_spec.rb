require 'rails_helper'

describe 'View Feedbacks List' do
  let!(:admin) { create(:admin) }
  let!(:feedback) { create_list(:feedback, 5) }

  def click_on_sidebar_feedback
    within '#sidebar-nav' do
      click_on 'Feedback'
    end
  end

  context 'Admin logged in' do
    it 'fetches all feedbacks and renders index view' do
      feature_login admin

      visit root_path

      click_on_sidebar_feedback
      expect(page).to have_content 'List of Feedbacks'
      expect(page.all('tr').count).to eql(6)
    end
  end
end
