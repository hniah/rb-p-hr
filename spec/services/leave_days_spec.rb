require 'rails_helper'

describe 'Add 14 leave days for staff when new year comes' do
  let!(:staffs) { create_list :staff, 4 }

  before do
    allow(Date).to receive(:today).and_return(Date.today.beginning_of_year)
    LeaveDays.add_leave_days_staff
  end

  context 'Add 14 leave days for staff when new year comes' do
    it 'Add 14 leave days for staff when new year comes' do

      expect(Leave.count).to eq 4
      expect(I18n.l(Leave.first.start_day)).to eq "01/01/#{Time.now.year}"
      expect(I18n.l(Leave.first.end_day)).to eq "31/12/#{Time.now.year}"
    end
  end
end
