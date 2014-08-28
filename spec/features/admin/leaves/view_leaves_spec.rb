require 'rails_helper'

describe 'View Leaves List' do
  let!(:staff) { create(:staff) }
  let!(:leaves) { create_list(:leave, 5, :with_leave_days, staff: staff, status: :pending) }

  context 'When admin logged in' do
    let(:admin) { create(:admin) }
    let!(:leave) { create(:leave, :with_leave_days) }

    it 'shows all leaves' do
      feature_login(admin)

      visit root_path

      click_on 'Leaves List'

      expect(page).to have_content 'Leaves List'
      expect(page.all('tr').count).to eql(6)
    end
  end
end
