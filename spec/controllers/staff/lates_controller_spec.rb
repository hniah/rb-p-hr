require 'rails_helper'

describe Staff::LatesController do
  describe '#index' do
    let(:staff) { create :staff }

    def do_request
      get :index
    end

    before { sign_in staff }
    before { staff.lates << create_list(:late, 3) }

    it 'renders lates list' do
      do_request
      expect(assigns(:lates)).to_not be_nil
      expect(assigns(:lates).size).to eq 3
    end
  end
end

