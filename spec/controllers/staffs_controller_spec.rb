require 'rails_helper'

describe StaffsController do
  describe 'Get #index' do
    let!(:staff) { create(:staff) }

    def do_request
      get :index
    end

    before{ create_list(:staff, 3) }
    context 'Admin logged in' do
      it 'fetches all users and renders index view' do
        do_request

        expect(assigns(:staffs).size).to eq 4
        expect(response).to render_template :index
      end
    end
  end
end
