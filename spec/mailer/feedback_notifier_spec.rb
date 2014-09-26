require 'rails_helper'

describe FeedbackNotifier do
  describe '.new_feedback' do
    let(:feedback) { create(:feedback) }
    let!(:FEEDBACK_RECEIVERS) { create :setting, key: 'FEEDBACK_RECEIVERS', value: 'jack@futureworkz.com,martin@futureworkz.com' }

    before { ActionMailer::Base.deliveries = [] }

    it 'sends feedback email to development team' do
      FeedbackNotifier.new_feedback(feedback).deliver
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries.first.subject).to include('New feedback from user')
      expect(ActionMailer::Base.deliveries.first.to).to include 'jack@futureworkz.com'
    end
  end
end
