require 'rails_helper'

describe 'Admin view staff lates list' do
  let(:admin) { create :admin }
  let(:staff) { create :staff }
  let!(:lates) { create_list :late, 3, staff: staff }
  let(:late) { lates.first }

  before { login_as admin }

  it 'displays staff lates list' do
    feature_login admin
    visit admin_staffs_path

    get_element("view-staff-#{staff.id}").click

    click_on 'View all my lates'

    expect(page).to have_content('List of Lates')
    expect(page).to have_content staff.english_name
  end
end
