require 'rails_helper'

describe 'View all staff history' do
  let(:admin) { create :admin }
  let!(:staff) { create :staff }

  before do
    create :version, item_id: staff.id, whodunnit: admin.id
  end

  it 'View all staff history' do
    feature_login admin
    visit admin_staffs_path

    get_element("view-staff-#{staff.id}").click

    click_on 'View all history'

    expect(page).to have_content 'Staff History'
    expect(page).to have_content admin.english_name
  end
end
