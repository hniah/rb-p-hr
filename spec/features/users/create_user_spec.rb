require 'rails_helper'

describe 'Create new Staff' do
  let!(:admin) { create :admin }

  context 'Valid data' do
    it 'Create new staff' do
      feature_login admin

      visit users_path

      click_on 'Add New Staff'

      fill_in 'Designation', with: 'Coder 123'
      fill_in 'Name', with: 'Vu Quang Thang'
      fill_in 'English name', with: 'Martin'
      fill_in 'Email', with: 'martin@futureworkz.com'
      fill_in 'Personal email', with: 'vuquangthang87@gmail.com'
      fill_in 'Birthday', with: '20/07/1987'
      fill_in 'Address', with: 'Lorem ipsum Lorem ipsum'
      fill_in 'Phone number', with: '012344567'
      fill_in 'Basic salary', with: 456
      fill_in 'Started on', with: '20/09/02014'
      fill_in 'Probation end on', with: '20/09/02014'
      fill_in 'Note', with: 'Lorem lorem'
      click_on 'Submit'

      expect(page).to have_content 'Staff List'
      expect(page).to have_content I18n.t('user.message.create_success')
      expect(page).to have_content 'Vu Quang Thang'

    end
  end

  context 'Invalid data' do
    it 'show the validation errors' do
      feature_login admin

      visit users_path

      click_on 'Add New Staff'

      fill_in 'Designation', with: 'Coder'
      fill_in 'Name', with: 'Vu Quang Thang'
      fill_in 'English name', with: 'Martin'
      fill_in 'Email', with: 'martin@futureworkz1.com'
      fill_in 'Personal email', with: 'vuquangthang87@gmail.com'
      fill_in 'Birthday', with: '20/07/1987'
      fill_in 'Address', with: 'Lorem ipsum Lorem ipsum'
      fill_in 'Phone number', with: '012344567'
      fill_in 'Basic salary', with: 456
      fill_in 'Started on', with: '20/09/02014'
      fill_in 'Probation end on', with: '20/09/02014'
      fill_in 'Note', with: 'Lorem lorem'
      click_on 'Submit'

      expect(page).to have_content 'Failed to create staff'
    end
  end
end
