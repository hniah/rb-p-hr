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

  describe 'get #new' do
    def do_request
      get :new
    end

    it 'renders new template' do
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
        do_request

        expect(Staff.first.email).to eq 'james@futureworkz.com'
        expect(response).to redirect_to staffs_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Failed' do
      let!(:staff_param) { attributes_for(:staff, email: '') }

      def do_request
        post :create, staff: staff_param
      end

      it 'renders template new and sets alert flash' do
        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'GET #edit' do
    let(:staff) { create(:staff) }

    def do_request
      get :edit, id: staff.id
    end

    it 'renders edit form' do
      do_request

      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:staff) { create(:staff) }

      def do_request
        patch :update, id: staff.id, staff: attributes_for(:staff, email: 'martin1234@futureworkz.com')
      end

      it 'updates user, redirects to list and sets notice flash' do
        do_request

        expect(response).to redirect_to staffs_path
        expect(flash[:notice]).to_not be_nil
        expect(staff.reload.email).to eq 'martin1234@futureworkz.com'
      end
    end

    context 'failed' do
      let(:staff) { create(:staff) }

      def do_request
        patch :update, id: staff.id, staff: attributes_for(:staff, email: '')
      end

      it 'renders template edit and sets alert flash' do
        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      let!(:staff) { create(:staff) }

      def do_request
        delete :destroy, id: staff.id
      end

      it 'redirects to list and sets notice flash' do
        expect { do_request }.to change(Staff, :count).by(-1)

        expect(response).to redirect_to staffs_path
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
