require 'rails_helper'

describe 'Edit Leave' do

  context 'Admin logged in' do
    let(:admin) { create(:admin) }
    let!(:staff) { create(:staff) }
    let!(:leave) { create(:leave, staff: staff, status: :pending) }
    before{ create :staff }

    it 'Edit Leave' do
      feature_login(admin)

      visit admin_leaves_path

      get_element("edit-leave-#{leave.id}").click

      select 'Compassionate', from: 'Category'
      fill_in 'Reason', with: 'Lorem lorem'
      click_on 'Update Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content 'Leave is successfully updated.'
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
