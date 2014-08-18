require 'rails_helper'

describe 'View staffs' do
  before { create_list(:staff, 5) }

  it 'display staffs list' do
    visit staffs_path

    expect(page).to have_content 'Staff List'
    expect(page).to have_content 'Martin'
  end
end
