require 'rails_helper'

describe Users::OmniauthCallbacksController do
  describe '#google_oauth2' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    def do_request
      post :google_oauth2
    end

    context 'User using futureworkz.com domain' do
      let!(:user) { create :user, email: 'test@futureworkz.com' }

      before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2].merge(info: {email: 'test@futureworkz.com'}) }

      it 'authenticates user' do
        do_request
        expect(controller.user_signed_in?).to be_truthy
        expect(controller.current_user).to eq user
      end
    end

    context 'User do not using futureworkz.com domain' do
      it 'authenticates user' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2].merge(info: {email: 'test@example.com'})

        expect { do_request }.not_to change(User, :count)
        expect(controller.user_signed_in?).to be_falsey
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
