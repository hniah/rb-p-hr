require 'rails_helper'

describe 'Show staff detail' do
  context 'Show staff detail' do
    let!(:staff) { create(:staff) }

    it 'show project detail' do
      visit root_path

      visit staffs_path

      get_element("view-staff-#{staff.id}").click

      expect(page).to have_content staff.name
      expect(page).to have_content staff.english_name
      expect(page).to have_content staff.email
      expect(page).to have_content staff.personal_email
    end
  end
end
