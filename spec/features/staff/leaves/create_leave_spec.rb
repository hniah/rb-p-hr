require 'rails_helper'

describe 'Display New Leave form' do
  context 'Staff logged in' do
    let!(:staff) { create :staff, leader: leader }
    let!(:staff_cc) { create :staff}
    let!(:leader) { create :user, email: 'khoa@futureworkz.com' }
    let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com' }

    it 'Create new leave' do
      visit root_path
      feature_login(staff)

      visit staff_leaves_path

      click_on 'Add New Leave'

      expect(page).to have_content('Please note that your team leader')
      select 'Annual', from: 'Category'
      fill_in 'Reason', with: 'Lorem lorem'
      fill_in 'Note', with: 'Lorem lorem'
      get_element('fill-in-start-day-leave').set('10/09/2014')
      get_element('select-start-time').set('8:30')
      get_element('fill-in-end-day-leave').set('10/09/2014')
      get_element('select-end-time').set('17:30')
      select staff_cc.english_name, from: 'Cc'

      fill_in 'Total', with: 1.0
      click_on 'Create Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content 'Leave is successfully created.'
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
