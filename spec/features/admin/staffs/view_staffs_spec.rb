require 'rails_helper'

describe 'View staffs' do
  let(:admin) { create :admin }
  before { create_list(:user, 5) }

  it 'display staffs list' do
    feature_login admin
    visit admin_staffs_path

    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Martin'
  end
end
