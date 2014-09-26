require 'rails_helper'

describe 'Show leave detail' do
  context 'Show leave detail' do
    let(:staff) { create :staff }
    let!(:leave) { create(:leave, staff: staff) }

    it 'show leave detail' do
      feature_login staff

      visit staff_leaves_path

      get_element("view-leave-#{leave.id}").click

      expect(page).to have_content leave.category.text
      expect(page).to have_content leave.staff_english_name
      expect(page).to have_content leave.reason
    end
  end
end
