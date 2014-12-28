require 'rails_helper'

describe 'Admin view lates list' do
  let(:admin) { create :admin }
  let!(:lates) { create_list :late, 3 }
  let(:late) { lates.first }

  before { login_as admin }

  it 'displays list of lates' do
    visit root_path
    click_on 'Late List'

    expect(page).to have_content('List of Lates')
    expect(page).to have_content late.staff.english_name
  end
end
