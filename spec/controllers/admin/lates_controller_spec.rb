require 'rails_helper'

describe Admin::LatesController do
  let(:admin) { create :admin }

  before { sign_in admin }

  context 'authentication' do
    it 'extends from AdminsController' do
      is_expected.to be_kind_of Admin::BaseController
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

    context 'Notify Admin when total late in current year >= 10' do
      let!(:lates_current_year) { create_list :late, 10, date: Date.today, staff: staff}
      let(:late_params) { attributes_for(:late).merge(staff_id: staff.id, date: Date.today) }
      let(:last_email) { ActionMailer::Base.deliveries.last }
      let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com' }

      it 'creates lates and set notice message' do
        expect { do_request }.to change(Late, :count).by(1)
        expect(response).to redirect_to admin_lates_url
        expect(last_email.to).to eq [Setting['EMAIL_NOTIFIER']]
        expect(last_email.subject).to have_content I18n.t('mail.late.subject')
        expect(flash[:notice]).to_not be_nil
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

  describe '#destroy' do
    let!(:late) { create :late }

    def do_request
      delete :destroy, id: late.id
    end

    context 'success' do
      it 'deletes late' do
        expect { do_request }.to change(Late, :count).by(-1)
        expect(flash[:notice]).to_not be_nil
        expect(response).to redirect_to admin_lates_url
      end
    end
  end

  describe 'GET #show' do
    context 'show late detail' do
      let(:late) { create :late }
      def do_request
        get :show, id: late.id
      end

      it 'render template show late detail and finds late' do
        sign_in admin

        do_request

        expect(response).to render_template :show
        expect(assigns(:late)).to_not be_nil
      end
    end
  end
end

