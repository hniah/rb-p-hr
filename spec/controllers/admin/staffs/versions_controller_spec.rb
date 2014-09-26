require 'rails_helper'

describe Admin::Staffs::VersionsController do
  let(:admin) { create :admin }
  let(:staff) { create :staff }

  describe 'GET #index' do
    context 'Admin logged in' do
      let!(:admin) { create :admin }

      before do
        create :version, item_id: staff.id, whodunnit: admin.id
      end

      def do_request
        get :index, staff_id: staff.id
      end

      it 'fetches all versions staff' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:versions).size).to eq 1
      end
    end
  end
end
