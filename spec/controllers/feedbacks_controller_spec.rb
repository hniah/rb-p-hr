require 'rails_helper'

describe FeedbacksController do
  let(:staff) { create(:staff) }

  before { sign_in staff }

  describe '#new' do
    def do_request
      get :new
    end

    it 'renders :new form' do
      do_request
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    def do_request
      post :create, feedback: feedback
    end

    context 'User enters valid parameters' do
      let(:feedback) { {kind: :bug, content: 'There is a bug in blah blah'} }

      it 'creates a feedback then redirects user back to home page' do
        expect { do_request }.to change(Feedback, :count).by(1)
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(response).to redirect_to root_url
      end
    end

    context 'User enters invalid parameters' do
      let(:feedback) { {kind: :hello, content: 'There is a bug in blah blah'} }

      it 'redirects user back to form and alerts him with a message' do
        expect { do_request }.to_not change(Feedback, :count)
        expect(response).to render_template :new
        expect(flash[:alert]).to_not be_nil
      end
    end
  end
end

