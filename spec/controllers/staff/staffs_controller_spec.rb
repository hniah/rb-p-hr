require 'rails_helper'

describe Staff::StaffsController do
  describe 'GET #show' do
    context 'show staff detail when current user is owner profile' do
      let(:staff) { create :staff }
      def do_request
        get :show
      end

      it 'render template show staff detail and finds staff' do
        sign_in staff
        do_request

        expect(response).to render_template :show
        expect(assigns(:staff)).to_not be_nil
      end
    end
  end
end
