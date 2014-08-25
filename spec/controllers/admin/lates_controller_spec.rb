require 'rails_helper'

describe Admin::LatesController do
  it { is_expected.to be_kind_of AdminsController } 
  
  describe '#new' do
    let(:admin) { create :admin }

    before { sign_in admin }

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
    let(:admin) { create :admin }
    let(:staff) { create :staff }

    def do_request
      post :create, late: late_params
    end

    before { sign_in admin }

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

      before { staff.lates << create_list(:late, 10) }

      it 'creates lates and set notice message' do
        expect { do_request }.to_not change(Late, :count)
        expect(response).to render_template(:new)
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

  describe '#index' do
    let(:admin) { create :admin }

    def do_request
      get :index
    end

    before { sign_in admin }
    before { create_list :late, 3 }

    it 'fetches all lates data' do
      do_request
      expect(assigns(:lates)).to_not be_empty
    end
  end
end

