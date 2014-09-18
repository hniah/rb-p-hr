require 'rails_helper'

describe 'Add 14 leave days for staff when new year comes' do
  let!(:staffs) { create_list :staff, 4 }

  before { LeaveDays.add_leave_days_staff }
  context 'Add 14 leave days for staff when new year comes' do
    it 'Add 14 leave days for staff when new year comes' do
      expect(Leave.count).to eq 4
      expect(Leave.first.start_day.strftime('%d/%m/%Y')).to eq "01/01/#{Time.now.year}"
      expect(Leave.first.end_day.strftime('%d/%m/%Y')).to eq "31/12/#{Time.now.year}"
    end
  end
end
