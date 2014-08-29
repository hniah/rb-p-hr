require 'rails_helper'

describe 'Show late detail' do
  context 'Show late detail' do
    let(:admin) { create :admin }
    let(:staff) { create :staff }
    let!(:late) { create(:late, staff: staff) }

    it 'show late detail' do
      feature_login admin

      visit admin_lates_path

      get_element("view-late-#{late.id}").click

      expect(page).to have_content late.date
      expect(page).to have_content late.staff_english_name
      expect(page).to have_content late.note
    end
  end
end
