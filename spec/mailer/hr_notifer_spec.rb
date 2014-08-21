require 'rails_helper'

describe HrNotifier do
  describe '#leave_come' do
    let(:leave) { create :leave }
    before do
      HrNotifier.leave_come('hr@futureworkz.com', leave).deliver
    end

    let(:last_email) { ActionMailer::Base.deliveries.last }

    context 'success' do
      it 'success' do
        expect(last_email.to).to eq ['hr@futureworkz.com']
        expect(last_email.subject).to eq 'New Leave Application'
        expect(last_email.body).to include 'Sickly'
      end
    end
  end
end
