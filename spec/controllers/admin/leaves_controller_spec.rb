require 'rails_helper'

describe Admin::LeavesController do
  let(:admin) { create :admin }
  let(:staff) { create :staff }
  let(:leave) { create :leave, status: :pending, staff: staff }
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
      end
    end
  end

end
