require 'rails_helper'

describe Staff::BaseController do
  controller(Staff::BaseController) do
    def index
      render nothing: true
    end
  end

  describe 'filter staff' do
    def do_request
      get :index
    end

    context 'staff is authenticated' do
      let(:user) { create :user }

      before { sign_in user }
      before { do_request }

      it 'allows staff to access' do
        expect(response).not_to redirect_to new_user_session_path
      end
    end

    context 'public user' do
      before { do_request }

      it 'disallows staff to access' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end

