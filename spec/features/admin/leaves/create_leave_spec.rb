require 'rails_helper'

describe 'Display New Leave form' do

  context 'Admin logged in' do
    let(:admin) { create(:admin) }
    let!(:staff) { create(:staff) }
    before{ create :staff }

    it 'Create new leave' do
      feature_login(admin)

      visit admin_leaves_path

      click_on 'Add New Leave'

      select 'Annual', from: 'Category'
      fill_in 'Reason', with: 'Lorem lorem'
      select staff.english_name, from: 'Staff'
      click_on 'Create Leave'

      expect(page).to have_content 'Leaves List'
      expect(page).to have_content 'Leave is successfully created.'
      expect(page).to have_content 'Lorem lorem'
    end
  end
end
