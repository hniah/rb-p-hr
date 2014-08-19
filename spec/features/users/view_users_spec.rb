require 'rails_helper'

describe 'View staffs' do
  before { create_list(:user, 5) }

  it 'display staffs list' do
    visit users_path

    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Martin'
  end
end
