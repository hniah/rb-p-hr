require 'rails_helper'

describe Admin::Staffs::LeavesController do
  let(:admin) { create :admin }
  let(:staff) { create :staff }

  describe 'GET #index' do
    context 'Admin logged in' do
      let!(:admin) { create :admin }

      before do
        create_list(:leave, 2, staff: staff)
      end

      def do_request
        get :index, staff_id: staff.id
      end

      it 'fetches all leaves date' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:leaves).size).to eq 2
      end
    end
  end
end
