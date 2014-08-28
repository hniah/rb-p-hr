require 'rails_helper'

describe 'Show staff detail' do
  context 'Show staff detail' do
    let!(:admin) { create :admin }
    let!(:staff) { create :staff }

    it 'show staff detail' do
      visit root_path
      feature_login admin

      visit admin_staffs_path

      get_element("view-staff-#{staff.id}").click

      expect(page).to have_content staff.name
      expect(page).to have_content staff.english_name
      expect(page).to have_content staff.email
      expect(page).to have_content staff.personal_email
    end
  end
end
