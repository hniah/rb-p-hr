require 'rails_helper'

describe 'Show staff profile' do
  let!(:staff) { create :staff }

  it 'Show staff profile' do
    feature_login staff
    visit root_path

    get_element('my-account').click

    expect(page).to have_content 'Your Account'
    expect(page).to have_content staff.name
    expect(page).to have_content staff.english_name
  end
end
