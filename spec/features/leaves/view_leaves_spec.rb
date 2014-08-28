require 'rails_helper'

describe 'View Leaves List' do
  let!(:staff) { create(:staff) }
  let!(:leaves) { create_list(:leave, 5, :with_leave_days, staff: staff, status: :pending) }

  context 'When user logged in' do
    it 'display leaves list' do
      feature_login(staff)

      visit staff_leaves_path
      expect(page).to have_content 'Leaves List'
      expect(page.all('tr').count).to eql(6)
    end
  end

  context 'When admin logged in' do
    let(:admin) { create(:admin) }
    let!(:leave) { create(:leave, :with_leave_days, status: :pending) }

    it 'shows all leaves' do
      feature_login(admin)

      visit root_path

      click_on 'Leaves List'

      expect(page).to have_content 'Leaves List'
      expect(page.all('tr').count).to eql(7)
    end
  end
end
