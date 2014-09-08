require 'rails_helper'

describe Admin::SettingsController do
  let!(:admin) { create :admin }

  describe '#index' do
    def do_request
      get :index
    end

    before { create_list :setting, 4 }

    context 'Admin logged in' do
      it 'fetches all settings and renders index view' do
        sign_in admin
        do_request

        expect(assigns(:settings).size).to eq 4
        expect(response).to render_template :index
      end
    end
  end

  describe '#new' do
    def do_request
      get :new
    end

    it 'renders new' do
      sign_in admin
      do_request

      expect(assigns(:setting)).to_not be_nil
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    def do_request
      post :create, setting: setting_params
    end

    context 'Admin fills in valid data' do
      let(:setting_params) { attributes_for(:setting, key: 'email_notifier', value: 'martin@futureworkz.com') }

      it 'creates setting and set notice message' do
        sign_in admin

        expect { do_request }.to change(Setting, :count).by(1)
        expect(response).to redirect_to admin_settings_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Admin fills in exists key' do
      let(:setting_params) { attributes_for(:setting, key: 'email_notifier', value: 'martin@futureworkz.com') }

      before { create :setting, key: 'email_notifier' }

      it 'renders template new and sets alert flash' do
        sign_in admin
        do_request

        expect(response).to render_template :index
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      let!(:setting) { create(:setting) }

      def do_request
        delete :destroy, id: setting.id
      end

      it 'redirects to list and sets notice flash' do
        sign_in admin
        expect { do_request }.to change(Setting, :count).by(-1)

        expect(response).to redirect_to admin_settings_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
