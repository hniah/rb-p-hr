require 'rails_helper'

describe 'View Leaves List' do
  let!(:staff) { create(:staff) }
  let!(:leaves) { create_list(:leave, 5, staff: staff) }

  context 'When user logged in' do
    it 'display leaves list' do
      feature_login(staff)

      visit leaves_path
      expect(page).to have_content 'Leaves List'
    end
  end

  context 'When admin logged in' do
    let(:admin) { create(:admin) }

    before { create_list(:leave, 3) }

    it 'shows all leaves' do
      feature_login(admin)

      visit root_path

      click_on 'Leaves List'
      expect(page).to have_content 'Leaves List'
      expect(page.all('tr').count).to eql(9)
    end
  end

end
