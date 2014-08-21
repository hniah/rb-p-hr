require 'rails_helper'

describe LeavesController do
  let!(:staff) { create :staff }

  describe 'GET #index' do
    def do_request
      get :index
    end

    context 'Staff logged in' do
      let!(:leaves) { create_list(:leave, 5, staff: staff)}

      before { expect(controller).to receive :authenticate_user! }

      it 'fetches all leaves date of current staff' do
        sign_in staff

        do_request

        expect(response).to render_template :index
        expect(assigns(:leaves).size).to eq 5
      end
    end

    context 'No user logged' do
      it 'redirects to root, sets alert flash' do
        do_request

        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to_not be_nil
      end
    end

    context 'Admin logged in' do
      let!(:admin) { create :admin }

      before do
        create_list(:leave, 2, staff: staff)
        create_list(:leave, 2, staff: admin.becomes(Staff))
      end

      def do_request
        get :index
      end

      it 'fetches all leaves date' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:leaves).size).to eq 4
      end
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end
    it 'renders template new and assigns new leave' do
      sign_in staff

      do_request

      expect(response).to render_template :new
      expect(assigns(:leave)).to_not be_nil
    end
  end

  describe 'POST #create' do
    context 'Success' do
      let(:leave_param) { attributes_for(:leave, date: '10/07/2014', kind: :morning) }
      let(:leave) { Leave.first }
      def do_request
        post :create, leave: leave_param
      end

      it 'creates leave, redirect to list, sets notice flash' do
        sign_in staff

        do_request

        expect(response).to redirect_to leaves_path
        expect(leave.kind).to eq 'morning'
        expect(leave.staff).to eq staff
        expect(flash[:notice]).to_not be_nil
      end
    end
    context 'Failed' do
      let(:leave_param) { attributes_for(:leave, date: '') }
      let(:leave) { Leave.first }
      def do_request
        post :create, leave: leave_param
      end

      it 'renders template new and sets the alert flash' do
        sign_in staff

        do_request

        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'get #edit' do
    let!(:leave) { create(:leave) }

    def do_request
      get :edit, id: leave.id
    end

    it 'renders template edit and finds work log' do
      sign_in staff

      do_request

      expect(response).to render_template :edit
      expect(assigns(:leave)).to_not be_nil
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:leave_param) { attributes_for(:leave, kind: :morning, date: '10/07/2014')}
      let(:leave) { create(:leave) }

      def do_request
        patch :update, id: leave.id, leave: leave_param
      end

      it 'updates work log, redirects to list and sets notice flash' do
        sign_in staff

        do_request

        expect(leave.reload.kind.text).to eq 'Morning'
        expect(response).to redirect_to leaves_path
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'failed' do
      let(:leave_param) { attributes_for(:leave, kind: 'Lorem', date: '10/07/2014', reason: '') }
      let(:leave) { create(:leave) }

      def do_request
        patch :update, id: leave.id, leave: leave_param
      end

      it 'renders template edit and sets alert flash' do
        sign_in staff

        do_request

        expect(response).to render_template :edit
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe 'delete #destroy' do
    let!(:leave) { create(:leave) }

    def do_request
      delete :destroy, id: leave.id
    end

    it 'deletes work log, redirects to list and sets notice flash' do
      sign_in staff

      do_request

      expect(response).to redirect_to leaves_path
      expect(flash[:notice]).to_not be_nil
    end
  end
end