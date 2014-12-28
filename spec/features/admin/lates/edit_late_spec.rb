require 'rails_helper'

describe 'Admin updates late' do
  let(:admin) { create :admin }
  let!(:lates) { create_list :late, 3 }
  let(:late) { lates.first }

  it 'updates late' do
    login_as admin
    visit root_path

    click_on 'Late List'
    get_element("edit-late-#{late.id}").click

    fill_in 'late[date]', with: '20/08/2014'
    fill_in 'Note', with: 'Just another note'
    click_on 'Update Late'

    expect(page).to have_content 'Late is successfully updated'
    expect(page).to have_content 'Just another note'
  end
end
