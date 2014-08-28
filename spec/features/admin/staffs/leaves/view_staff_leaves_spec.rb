require 'rails_helper'

describe 'View all staff leaves' do
  let(:admin) { create :admin }
  let!(:staff) { create :staff }
  let!(:leaves) { create_list :leave, 3, :with_leave_days, staff: staff }

  it 'View all staff leaves' do
    feature_login admin
    visit admin_staffs_path

    get_element("view-staff-#{staff.id}").click

    click_on 'View all my leaves'

    expect(page).to have_content 'Leaves List'
    expect(page).to have_content staff.english_name
  end
end
