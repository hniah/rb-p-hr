require 'rails_helper'

describe 'User submit feedback feature' do
  let(:staff) { create :staff }

  context 'System allows staff to add feedback' do

    it 'saves the feedback and show thank you message' do
      feature_login staff
      visit root_url

      click_on 'Feedback/Bug Report'

      select 'Feedback', from: 'Kind'
      fill_in 'Content', with: 'This is a feedback'
      click_on 'Create Feedback'

      expect(page).to have_content 'Thanks for your submission'
    end
  end
end
