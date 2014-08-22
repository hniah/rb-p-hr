require 'rails_helper'

describe SystemNotifier do
  describe 'notify hr' do
    let(:leave) { create :leave }
    before do
      SystemNotifier.notify('hr@futureworkz.com', leave, 'New Leave Application', 'notifier/hr_notifier').deliver
    end

    let(:last_email) { ActionMailer::Base.deliveries.last }

    context 'notify hr when leave come' do
      it 'notify hr when leave come' do
        expect(last_email.to).to eq ['hr@futureworkz.com']
        expect(last_email.subject).to eq 'New Leave Application'
        expect(last_email.body).to include 'Sickly'
      end
    end
  end
end
