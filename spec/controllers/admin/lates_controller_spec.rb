require 'rails_helper'

describe Admin::LatesController do
  let(:admin) { create :admin }

  before { sign_in admin }

  context 'authentication' do
    it 'extends from AdminsController' do
      is_expected.to be_kind_of AdminsController
    end 
  end
  
  describe '#new' do
    def do_request
      get :new
    end

    it 'renders new' do
      do_request
      expect(assigns(:late)).to_not be_nil
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    let(:staff) { create :staff }

    def do_request
      post :create, late: late_params
    end

    context 'Admin fills in valid data' do
      let(:late_params) { attributes_for(:late).merge(staff_id: staff.id) }

      it 'creates lates and set notice message' do
        expect { do_request }.to change(Late, :count).by(1)
        expect(response).to redirect_to admin_lates_url
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Admin fills in invalid data' do
      let(:late_params) { {lorem: 'ipsum', staff_id: staff.id} }

      before { staff.lates << build_list(:late, 10) }

      it 'creates lates and set notice message' do
        expect { do_request }.to_not change(Late, :count)
        expect(response).to render_template(:new)
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe '#index' do
    def do_request
      get :index
    end

    before { create_list :late, 3 }

    it 'fetches all lates data' do
      do_request
      expect(assigns(:lates)).to_not be_empty
    end
  end

  describe '#edit' do
    let(:late) { create :late }

    def do_request
      get :edit, id: late.id
    end

    context 'success' do
      it 'renders edit template' do
        do_request
        expect(assigns(:late)).to_not be_nil
        expect(response).to render_template :edit
      end
    end
  end

  describe '#update' do
    let(:late) { create :late }

    def do_request
      patch :update, id: late.id, late: late_params
    end

    context 'Admin fills in valid parameters' do
      let(:late_params) { {note: 'Just another note'} }

      it 'updates late then redirects user to lates list' do
        do_request
        expect(response).to redirect_to admin_lates_url
        expect(flash[:notice]).to_not be_nil 
      end
    end
  end
end

