require 'rails_helper'

describe 'Display New Leave form' do
  context 'Staff logged in' do
    let(:staff) { create(:staff) }

    it 'Create new leave' do
      feature_login(staff)

      visit staff_leaves_path

      click_on 'Add New Leave'

      select 'Annual', from: 'Category'
      fill_in 'Reason', with: 'Lorem lorem'
      click_on 'Create Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.create_success')
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
