require 'rails_helper'

describe 'Show staff profile' do
  let!(:staff) { create :staff }
  before{ create :staff }

  it 'Show staff profile' do
    visit root_path
    feature_login staff

    click_on 'My Account'

    expect(page).to have_content 'My account'
    expect(page).to have_content staff.name
    expect(page).to have_content staff.english_name
  end
end
