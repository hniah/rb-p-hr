require 'rails_helper'

describe 'Display New Leave form' do
  context 'Staff logged in' do
    let(:staff) { create(:staff) }

    it 'Create new leave' do
      feature_login(staff)

      visit leaves_path

      click_on 'Add New Leave'

      select 'Annual', from: 'Types'
      fill_in 'Date', with: '10/07/2014'
      select 'Whole day', from: 'Kind'
      fill_in 'Reason', with: 'Lorem lorem'
      click_on 'Create Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.create_success')
      expect(page).to have_content 'Lorem lorem'
    end
  end

  context 'Admin logged in' do
    let(:admin) { create(:admin) }
    let!(:staff) { create(:staff) }
    before{ create :staff }

    it 'Create new leave' do
      feature_login(admin)

      visit leaves_path

      click_on 'Add New Leave'

      select 'Annual', from: 'Types'
      fill_in 'Date', with: '10/07/2014'
      select 'Whole day', from: 'Kind'
      fill_in 'Reason', with: 'Lorem lorem'
      select staff.english_name, from: 'Staff'
      click_on 'Create Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content I18n.t('leave.message.create_success')
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
