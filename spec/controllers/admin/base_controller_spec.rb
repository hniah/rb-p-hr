require 'rails_helper'

describe Admin::BaseController do
  controller(Admin::BaseController) do
    def index
      render nothing: true
    end
  end

  describe 'filter admin' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }

    def do_request
      get :index
    end

    context 'admin is authenticated' do
      let(:admin) { create(:admin) }

      before { sign_in admin }
      before { do_request }

      it 'allows admin to access' do
        expect(response).not_to redirect_to root_path
      end

    end

    context 'staff is authenticated' do
      let(:user) { create :user }

      before { sign_in user }
      before { do_request }

      it 'disallows normal staff to access' do
        expect(response).to redirect_to root_path
      end
    end

    context 'public user' do
      before { do_request }

      it 'disallows public user to access' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

