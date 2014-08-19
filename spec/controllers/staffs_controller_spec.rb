require 'rails_helper'

describe StaffsController do
  describe 'get #show' do
    context 'show staff detail' do
      let(:staff) { create :staff }
      def do_request
        get :show, id: staff.id
      end

      it 'render template show project detail and finds project' do
        sign_in staff

        do_request

        expect(response).to render_template :show
        expect(assigns(:staff)).to_not be_nil
      end
    end
  end
end
