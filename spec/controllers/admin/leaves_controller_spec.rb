require 'rails_helper'

describe Admin::LeavesController do
  let(:admin) { create :admin }
  let(:staff) { create :staff }
  let(:leave) { create :leave, :with_leave_days, status: :pending, staff: staff }
  let(:last_email) { ActionMailer::Base.deliveries.last }

  describe '#approve' do
    def do_request
      patch :approve, id: leave.id
    end

    context 'approve' do
      it 'Admin approves a leave' do
        sign_in admin
        do_request

        expect(response).to redirect_to leaves_path
        expect(leave.reload.status.text).to eq 'Approved'
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.body).to have_content "Dear #{leave.staff_english_name}"
        expect(last_email.body).to have_content 'approved'
        expect(last_email.body).to have_content "#{leave.days_total} days"
        expect(last_email.body).to have_content leave.dates
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

        expect(response).to redirect_to leaves_path
        expect(leave.reload.status.text).to eq 'Rejected'
        expect(leave.reload.rejection_note).to eq 'Reject by your teamleader'
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.body).to have_content "Dear #{leave.staff_english_name}"
        expect(last_email.body).to have_content 'rejected'
        expect(last_email.body).to have_content "#{leave.days_total} day"
        expect(last_email.body).to have_content leave.dates
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
      let(:leave_days) { [attributes_for(:leave_day)] }
      let(:leave_param) { attributes_for(:leave, staff_id: staff.id, leave_days_attributes: leave_days) }
      let(:leave) { Leave.first }
      let(:last_email) { ActionMailer::Base.deliveries.last }
      def do_request
        post :create, leave: leave_param
      end

      it 'creates leave, redirect to list, sets notice flash' do
        sign_in admin
        do_request

        expect(response).to redirect_to leaves_path
        expect(leave.staff).to eq staff
        expect(leave.reload.leave_days.size).to eq 1
        expect(last_email.to).to eq [ENV['EMAIL_NOTIFIER']]
        expect(last_email.body).to have_content 'New leave application'
        expect(last_email.body).to have_content leave.reason
        expect(flash[:notice]).to_not be_nil
      end
    end

    context 'Failed' do
      let(:leave_param) { attributes_for(:leave, date: '', reason: '') }
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
end
