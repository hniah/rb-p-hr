require 'rails_helper'

describe 'Edit Work Log' do

  context 'Staff logged in' do
    let(:staff) { create(:staff) }
    let!(:leave) { create(:leave, staff: staff) }

    it 'Edit work log success' do
      feature_login staff

      visit leaves_path

      get_element("edit-leave-#{leave.id}").click

      expect(page).to have_content 'Edit Leave'
      fill_in 'Date', with: '10/07/2014'
      select 'Afternoon', from: 'Kind'
      click_on 'Update Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.update_success')
    end
  end

  context 'Admin logged in' do
    let(:admin) { create(:admin) }
    let!(:staff) { create(:staff) }
    let!(:leave) { create(:leave, staff: staff) }
    before{ create :staff }

    it 'Create new leave' do
      feature_login(admin)

      visit leaves_path

      get_element("edit-leave-#{leave.id}").click

      fill_in 'Date', with: '10/07/2014'
      select 'Whole day', from: 'Kind'
      fill_in 'Reason', with: 'Lorem lorem'
      select 'Approve', from: 'Status'
      click_on 'Update Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.update_success')
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
