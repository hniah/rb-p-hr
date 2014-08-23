require 'rails_helper'

describe FeedbackNotifier do
  describe '.new_feedback' do
    let(:feedback) { create(:feedback) }

    before { ActionMailer::Base.deliveries = [] }

    it 'sends feedback email to development team' do
      FeedbackNotifier.new_feedback(feedback).deliver
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries.first.subject).to include("New feedback from user")
    end
  end
end
