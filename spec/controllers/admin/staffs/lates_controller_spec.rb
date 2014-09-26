require 'rails_helper'

describe Admin::Staffs::LatesController do
  let(:admin) { create :admin }
  let(:staff) { create :staff }

  before { sign_in admin }

  context 'authentication' do
    it 'extends from AdminsController' do
      is_expected.to be_kind_of Admin::BaseController
    end 
  end

  describe '#index' do
    def do_request
      get :index, staff_id: staff.id
    end

    before { create_list :late, 3, staff: staff }

    it 'fetches all staff lates' do
      do_request

      expect(assigns(:lates)).to_not be_empty
    end
  end
end

