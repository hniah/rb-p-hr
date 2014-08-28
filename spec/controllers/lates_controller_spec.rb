require 'rails_helper'

describe LatesController do
  let(:staff) { create :staff }

  before { sign_in staff }

  describe '#index' do
    def do_request
      get :index
    end

    before { create_list :late, 3, staff: staff }

    it 'fetches all staff lates' do
      do_request

      expect(assigns(:lates)).to_not be_empty
    end
  end
end

