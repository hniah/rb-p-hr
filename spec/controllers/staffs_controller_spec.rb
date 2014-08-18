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

end
