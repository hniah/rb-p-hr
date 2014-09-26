require 'rails_helper'

describe SystemNotifier do
  describe 'notify hr' do
    let(:leave) { create :leave }
    let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com' }

    let(:last_email) { ActionMailer::Base.deliveries.last }

    context 'notify hr when leave come' do
      it 'notify hr when leave come' do
        LeaveNotifier.new_leave(leave).deliver
        expect(last_email.to).to eq ['jack@futureworkz.com']
        expect(last_email.subject).to eq 'New Leave Application'
        expect(last_email.body).to include 'Sickly'
      end
    end
  end

  describe 'notify staff when leave is approved' do
    let(:leave) { create :leave }
    before do
      LeaveNotifier.approved(leave).deliver
    end

    let(:last_email) { ActionMailer::Base.deliveries.last }

    context 'notify hr when leave is approved' do
      it 'notify hr when leave is approved' do
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.subject).to eq 'Your Leave is Approved'
        expect(last_email.body).to include 'approved'
      end
    end
  end

  describe 'notify staff when sick leave is approved' do
    let(:leave) { create :leave, category: :sick }
    before do
      LeaveNotifier.approved(leave).deliver
    end

    let(:last_email) { ActionMailer::Base.deliveries.last }

    context 'notify hr when sick leave is approved' do
      it 'notify hr when sick leave is approved' do
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.subject).to eq 'Your Sick Leave is Approved'
        expect(last_email.body).to include 'Take good care and we wish you full recovery soon.'
      end
    end
  end

  describe 'notify staff when leave is rejected' do
    let(:leave) { create :leave }
    before do
      LeaveNotifier.rejected(leave).deliver
    end

    let(:last_email) { ActionMailer::Base.deliveries.last }

    context 'notify hr when leave is rejected' do
      it 'notify hr when leave is rejected' do
        expect(last_email.to).to eq ["#{leave.staff_email}"]
        expect(last_email.subject).to eq 'Your Leave is Rejected'
        expect(last_email.body).to include 'rejected'
      end
    end
  end
end
