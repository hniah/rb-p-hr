require 'rails_helper'

describe LateNotifier do
  describe '.more_late' do
    let(:staff) { create :staff }
    let(:late) { create(:late , staff: staff) }
    let!(:EMAIL_NOTIFIER) { create :setting, key: 'EMAIL_NOTIFIER', value: 'jack@futureworkz.com' }

    before { ActionMailer::Base.deliveries = [] }

    it 'System to prompt admin if staff has more than 10 lates this year' do
      LateNotifier.more_late(late).deliver
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries.first.subject).to include('Staff has more than 10 lates this year')
      expect(ActionMailer::Base.deliveries.first.to).to include 'jack@futureworkz.com'
    end
  end
end
