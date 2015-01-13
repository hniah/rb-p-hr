require 'rails_helper'

describe Staff::LeavesController do
  let(:leader) { create :user, email: 'khoa@futureworkz.com' }
  let!(:staff) { create :staff, leader: leader }

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
      let(:leave_param) { attributes_for(:leave, start_time: '8:30', 
                                                  end_time: '12:00', 
                                                  start_date: '2014-09-11', 
                                                  end_date: '2014-09-12', 
                                                  total_value: 1.0,
                                                  emails_cc: ['john@futureworkz.com', 'jack@futureworkz.com']
                                                  ) }
      let(:leave) { Leave.first }
      let(:last_email) { ActionMailer::Base.deliveries.last }
      let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com' }
      let(:cc) { leave_param[:emails_cc].push(leader.email) }
      
      def do_request
        post :create, leave: leave_param
      end

      it 'creates leave, redirect to list, sets notice flash' do
        sign_in staff
        do_request

        expect(response).to redirect_to staff_leaves_path
        expect(leave.staff).to eq staff
        expect(last_email.cc.size).to eq 3
        expect(last_email.cc).to match_array cc
        expect(last_email.to).to eq [Setting['EMAIL_NOTIFIER']]
        expect(last_email.body).to have_content 'New leave application'
        expect(last_email.body).to have_content leave.reason
        expect(leave.reload.start_time).to eq '08:30'
        expect(leave.reload.end_time).to eq '12:00'
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Failed' do
      let(:leave_param) { attributes_for(:leave, date: '', reason: '', start_time: '8:30', end_time: '12:00', start_date: '2014-09-11', end_date: '2014-09-12') }
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

    context 'Warning staff when staff try to apply at least 3 working days' do
      before do
        allow(Date).to receive(:today) { Date.new(2014,9,9) }
      end
      let(:leave_param) { attributes_for(:leave, start_time: '8:30',
                                         category: :annual,
                                         end_time: '12:00',
                                         start_date: '2014-09-11',
                                         end_date: '2014-09-12',
                                         total_value: 1.0,
                                         emails_cc: ['john@futureworkz.com', 'jack@futureworkz.com']
      ) }
      let(:leave) { Leave.first }
      let(:last_email) { ActionMailer::Base.deliveries.last }
      let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com' }
      let(:cc) { leave_param[:emails_cc].push(leader.email) }

      def do_request
        post :create, leave: leave_param
      end

      it 'creates leave, redirect to list, sets notice flash, send mail notify' do
        sign_in staff
        do_request

        expect(response).to redirect_to staff_leaves_path
        expect(leave.staff).to eq staff
        expect(last_email.body).to have_content 'least 3 working days'
        expect(leave.reload.start_time).to eq '08:30'
        expect(leave.reload.end_time).to eq '12:00'
        expect(flash[:notice]).to_not be_nil
      end
    end
  end

  describe 'GET #show' do
    context 'show leave detail' do
      let(:leave) { create :leave }
      def do_request
        get :show, id: leave.id
      end

      it 'render template show leave detail and finds leave' do
        sign_in staff

        do_request

        expect(response).to render_template :show
        expect(assigns(:leave)).to_not be_nil
      end
    end
  end
end
