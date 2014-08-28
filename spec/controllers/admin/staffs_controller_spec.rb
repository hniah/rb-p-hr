require 'rails_helper'

describe Admin::StaffsController do
  let!(:admin) { create :admin }

  describe 'Get #index' do
    def do_request
      get :index
    end

    before{ create_list(:user, 3) }

    context 'Admin logged in' do
      it 'fetches all users and renders index view' do
        sign_in admin
        do_request

        expect(assigns(:users).size).to eq 4
        expect(response).to render_template :index
      end
    end
  end

  describe 'get #new' do
    def do_request
      get :new
    end

    it 'renders new template' do
      sign_in admin
      do_request

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'success' do
      let!(:staff_param) { attributes_for(:staff, email: 'james@futureworkz.com') }

      def do_request
        post :create, staff: staff_param
      end

      it 'creates a new user, redirects to list and sets notice flash' do
        sign_in admin
        do_request

        expect(User.first.email).to eq 'james@futureworkz.com'
        expect(response).to redirect_to admin_staffs_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Failed' do
      let!(:staff_param) { attributes_for(:staff, email: '') }

      def do_request
        post :create, staff: staff_param
      end

      it 'renders template new and sets alert flash' do
        sign_in admin
        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user) }

    def do_request
      get :edit, id: user.id
    end

    it 'renders edit form' do
      sign_in admin
      do_request

      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:user) { create(:user) }

      def do_request
        patch :update, id: user.id, staff: attributes_for(:staff, email: 'martin1234@futureworkz.com', password: '123123123', password_confirmation: '123123123')
      end

      it 'updates user, redirects to list and sets notice flash' do
        sign_in admin
        do_request

        expect(response).to redirect_to admin_staffs_path
        expect(flash[:notice]).to_not be_nil
        expect(user.reload.email).to eq 'martin1234@futureworkz.com'
        expect(user.password).to eq '123123123'
      end
    end

    context 'failed' do
      let(:user) { create(:user) }

      def do_request
        patch :update, id: user.id, staff: attributes_for(:staff, email: '')
      end

      it 'renders template edit and sets alert flash' do
        sign_in admin
        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      let!(:user) { create(:user) }

      def do_request
        delete :destroy, id: user.id
      end

      it 'redirects to list and sets notice flash' do
        sign_in admin
        expect { do_request }.to change(User, :count).by(-1)

        expect(response).to redirect_to admin_staffs_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end

  describe 'get #show' do
    context 'show staff detail' do
      let(:user) { create :user }

      def do_request
        get :show, id: user.id
      end

      it 'render template show staff detail and finds staff' do
        sign_in admin
        do_request

        expect(response).to render_template :show
        expect(assigns(:user)).to_not be_nil
      end
    end
  end
end
