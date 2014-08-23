require 'rails_helper'

describe Admin::FeedbacksController do
  describe '#index' do
    let(:admin) { create :admin }
    let!(:feedbacks) { create_list :feedback, 5 }

    def do_request
      get :index
    end

    context 'Admin logged in' do
      it 'fetches all leaves date' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:feedbacks).size).to eq 5
      end
    end

    context 'Staff logged in' do
      let(:staff) { create :staff }
      it 'redirects to root, sets alert flash' do
        sign_in staff
        do_request

        expect(response).to redirect_to root_path
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end
