require 'rails_helper'

describe 'Edit Leave' do

  context 'Admin logged in' do
    let(:admin) { create(:admin) }
    let!(:staff) { create(:staff) }
    let!(:leave) { create(:leave, :with_leave_days, staff: staff, status: :pending) }
    before{ create :staff }

    it 'Edit Leave' do
      feature_login(admin)

      visit admin_leaves_path

      get_element("edit-leave-#{leave.id}").click

      select 'Compassionate', from: 'Category'
      fill_in 'Reason', with: 'Lorem lorem'
      get_element('fill-in-date-0').set('10/07/2014')
      get_element('select-kind-0').select('Whole day')
      click_on 'Update Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.update_success')
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
