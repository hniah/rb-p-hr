require 'rails_helper'

describe 'Admin delete late' do
  let(:admin) { create :admin }
  let!(:lates) { create_list :late, 3 }
  let(:late) { lates.first }

  before { login_as admin }

  it 'displays list of lates' do
    visit root_path
    click_on 'Late List'
    get_element("delete-late-#{late.id}").click

    expect(page).to have_content 'Late is successfully deleted'
  end
end
