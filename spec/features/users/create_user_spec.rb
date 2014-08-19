require 'rails_helper'

describe 'Create new Staff' do

  context 'Valid data' do
    it 'Create new staff' do
      visit users_path

      click_on 'Add new staff'

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
      fill_in 'Password', with: '123123123'
      fill_in 'Password confirmation', with: '123123123'
      click_on 'Submit'

      expect(page).to have_content 'Staff List'
      expect(page).to have_content I18n.t('user.message.create_success')
      expect(page).to have_content 'Vu Quang Thang'

    end
  end
end
