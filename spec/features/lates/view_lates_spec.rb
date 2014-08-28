require 'rails_helper'

describe 'Admin view lates list' do
  let(:staff) { create :staff }
  let!(:lates) { create_list :late, 3, staff: staff }
  let(:late) { lates.first }

  before { login_as staff }

  it 'displays list of lates' do
    visit root_path

    click_on 'My Account'

    click_on 'View all my lates'

    expect(page).to have_content('List of Late')
    expect(page).to have_content late.staff.english_name
    expect(page.all('tr').count).to eql(4)
  end
end
