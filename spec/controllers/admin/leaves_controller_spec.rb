require 'rails_helper'

describe Admin::LeavesController do
  let(:admin) { create :admin }
  let(:staff) { create :staff }
  let(:leave) do
    create :leave,
      category: :sick,
      status: :pending, 
      staff: staff, 
      start_date: '19/09/2014 8:30', 
      end_date: '20/09/2014 17:30'
  end
  let(:last_email) { ActionMailer::Base.deliveries.last }
  let!(:EMAIL_NOTIFIER) do
    create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com'
  end

  describe '#approve' do
    def do_request
      patch :approve, id: leave.id
    end

    context 'approve' do
      it 'Admin approves a leave' do
        sign_in admin
        do_request

        expect(response).to redirect_to admin_leaves_path
        expect(leave.reload.status.text).to eq 'Approved'
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.body).to have_content "Dear #{leave.staff_english_name}"
        expect(last_email.body).to have_content 'recorded'
      end
    end

    context 'Notify User and Admin when Sick leave of more than 7 times in a period of a year' do
      before do
        allow(Date).to receive(:today) { Date.new(2014,9,19) }
      end

      let!(:sick_leaves_prev_year) { create_list :leave, 6,category: :sick, reason: 'Sickly',status: :approved, total: -1,staff: staff, start_date: '19/01/2013 8:30',end_date: '20/01/2013 17:30' }
      let!(:sick_leaves_current_year) { create_list :leave, 14,category: :sick, reason: 'Sickly',status: :approved, total: -0.5,staff: staff, start_date: '19/01/2014 8:30',end_date: '20/01/2014 17:30' }


      it 'Admin approves a leave' do
        sign_in admin
        do_request

        expect(response).to redirect_to admin_leaves_path
        expect(leave.reload.status.text).to eq 'Approved'
        expect(last_email.body).to have_content "Dear #{leave.staff_english_name}"
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.body).to have_content 'more than 7 sick leaves'
        expect(last_email.cc).to eq [Setting['EMAIL_NOTIFIER']]
      end
    end
  end

  describe '#reject' do
    def do_request
      get :reject, id: leave.id
    end

    context 'reject leave' do
      it 'Admin reject a leave and inputs note' do
        sign_in admin
        do_request

        expect(response).to render_template :reject
        expect(assigns(:leave)).to_not be_nil
      end
    end
  end

  describe '#reject_action' do
    let(:leave_param) { attributes_for(:leave, rejection_note: 'Reject by your teamleader')}

    def do_request
      patch :reject_action, id: leave.id, leave: leave_param
    end

    context 'reject leave and redirect to leaves list' do
      it 'reject leave and redirect to leaves list' do
        sign_in admin
        do_request

        expect(response).to redirect_to admin_leaves_path
        expect(leave.reload.status.text).to eq 'Rejected'
        expect(leave.reload.rejection_note).to eq 'Reject by your teamleader'
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.body).to have_content "Dear #{leave.staff_english_name}"
        expect(last_email.body).to have_content 'rejected'
      end
    end
  end

  describe 'GET #index' do
    context 'fetches all leaves pending when filter is pending' do
      let!(:admin) { create :admin }

      before do
        create_list(:leave, 2, staff: staff, status: :pending)
        create_list(:leave, 2, staff: admin.becomes(Staff), status: :approved)
      end

      def do_request
        get :index, status: 'pending'
      end

      it 'fetches all leaves pending' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:leaves).size).to eq 2
      end
    end

    context 'fetches all leaves when filter is all' do
      let!(:admin) { create :admin }

      before do
        create_list(:leave, 2, staff: staff, status: :approved)
        create_list(:leave, 2, staff: admin.becomes(Staff), status: :approved)
      end

      def do_request
        get :index, status: 'all'
      end

      it 'fetches all leaves when filter is all' do
        sign_in admin

        do_request

        expect(response).to render_template :index
        expect(assigns(:leaves).size).to eq 4
      end
    end

    context 'data filtering' do
      let!(:last_leave) do
        create :leave, 
          start_day: Time.now.change(year: 2020), 
          end_day: Time.now.change(year: 2021)
      end

      before { create_list :leave, 3 }
      before { sign_in admin }

      def do_request
        get :index, sort_column: :start_day, sort_direction: :desc
      end

      it 'filters data by column names' do
        do_request
        expect(assigns(:leaves).first).to eq last_leave
      end
    end
  end

  describe 'GET #new' do
    def do_request
      get :new
    end

    it 'renders template new and assigns new leave' do
      sign_in admin
      do_request

      expect(response).to render_template :new
      expect(assigns(:leave)).to_not be_nil
    end
  end

  describe 'POST #create' do
    context 'Success' do
      let(:leave_param) do 
        attributes_for(:leave, staff_id: martin.id, start_time: '8:30', 
          end_time: '12:00', start_date: '2014-09-19', 
          end_date: '2014-09-22', total_value: 1.5, 
          emails_cc: ['john@futureworkz.com', 'jack@futureworkz.com']) 
      end
      let(:leader) { create :user, email: 'khoa@futureworkz.com' }
      let!(:martin) { create :user, email: 'martin@futureworkz.com', leader: leader }
      let(:leave) { Leave.first }
      let(:last_email) { ActionMailer::Base.deliveries.last }
      let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', 
                                                value: 'jack@futureworkz.com' }
     
      let(:cc) { leave_param[:emails_cc].push(leader.email) }
                                               
      def do_request
        post :create, leave: leave_param
      end

      it 'creates leave, redirect to list, sets notice flash' do
        sign_in admin
        do_request

        expect(response).to redirect_to admin_leaves_path
        expect(last_email.to).to eq [Setting['EMAIL_NOTIFIER']]
        expect(last_email.cc.size).to eq 3
        expect(last_email.cc).to match_array cc
        expect(last_email.body).to have_content 'New leave application'
        expect(last_email.body).to have_content leave.reason
        expect(leave.reload.total). to eq -1.5
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Failed' do
      let(:leave_param) { attributes_for(:leave, date: '', reason: '', start_time: '8:30', end_time: '17:30', start_date: '2014-09-11', end_date: '2014-09-11', total_value: 1.0) }
      let(:leave) { Leave.first }

      def do_request
        post :create, leave: leave_param
      end

      it 'renders template new and sets the alert flash' do
        sign_in admin

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
      sign_in admin

      do_request

      expect(response).to render_template :edit
      expect(assigns(:leave)).to_not be_nil
    end
  end

  describe 'PATCH #update' do
    context 'success' do
      let(:leave_param) { attributes_for(:leave, start_date: '2014-09-16', start_time: '8:30', end_date: '2014-09-16', end_time: '17:30', total_value: 1.0)}
      let(:leave) { create(:leave) }

      def do_request
        patch :update, id: leave.id, leave: leave_param
      end

      it 'updates leave, redirects to list and sets notice flash' do
        sign_in admin
        do_request

        expect(response).to redirect_to admin_leaves_path
        expect(flash[:notice]).to_not be_nil
        expect(leave.reload.start_day.strftime('%d/%m/%Y')). to eq '16/09/2014'
        expect(leave.reload.end_day.strftime('%d/%m/%Y')). to eq '16/09/2014'
        expect(leave.reload.total). to eq -1.0
      end
    end

    context 'failed' do
      let(:leave_param) { attributes_for(:leave, reason: '', start_time: '8:30', end_time: '17:30', start_date: '2014-09-11', end_date: '2014-09-11', total_value: 1.0) }
      let(:leave) { create(:leave) }

      def do_request
        patch :update, id: leave.id, leave: leave_param
      end

      it 'renders template edit and sets alert flash' do
        sign_in admin

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

    it 'deletes leave, redirects to list and sets notice flash' do
      sign_in admin

      do_request

      expect(response).to redirect_to admin_leaves_path
      expect(flash[:notice]).to_not be_nil
    end
  end

  describe 'GET #show' do
    context 'show leave detail' do
      let(:leave) { create :leave }

      def do_request
        get :show, id: leave.id
      end

      it 'render template show leave detail and finds leave' do
        sign_in admin

        do_request

        expect(response).to render_template :show
        expect(assigns(:leave)).to_not be_nil
      end
    end
  end
end
