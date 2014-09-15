require 'rails_helper'

describe 'Display New Leave form' do
  context 'Staff logged in' do
    let(:staff) { create(:staff) }

    it 'Create new leave' do
      feature_login(staff)

      visit staff_leaves_path

      click_on 'Add New Leave'

      select 'Annual', from: 'Category'
      get_element('fill-in-start-day-leave').set('10/09/2014')
      get_element('select-start-time').set('8:30')
      get_element('fill-in-end-day-leave').set('10/09/2014')
      get_element('select-end-time').set('17:30')
      fill_in 'Reason', with: 'Lorem lorem'
      click_on 'Create Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.create_success')
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
