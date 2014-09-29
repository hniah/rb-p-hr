require 'rails_helper'

describe LeaveDays do
  describe 'Add 14 leave days for staff when new year comes' do
    let!(:staffs) { create_list :staff, 2 }

    before do
      allow(Date).to receive(:today).and_return(Date.today.beginning_of_year)
      LeaveDays.add_leave_days_staff
    end

    context 'Add 14 leave days for staff when new year comes' do
      it 'Add 14 leave days for staff when new year comes' do
        expect(Leave.count).to eq 4
        expect(I18n.l(Leave.last.start_day)).to eq "01/01/#{Time.now.year}"
        expect(I18n.l(Leave.last.end_day)).to eq "31/12/#{Time.now.year}"
        expect(Leave.last.sub_cate).to eq 'normal'
      end
    end
  end

  describe '' do
    let!(:staffs) { create_list :staff, 2 }
    let!(:martin) { create :staff }
    let!(:total_leave_in_last_year) { create :leave, category: :annual, status: :approved, start_day: '2013-01-01 8:30', end_day: '2013-12-31 17:30', total: 14, staff: martin}
    let!(:leave_days_in_last_year_martin) { create_list :leave, 3, staff: martin, status: :approved, category: :annual, start_day: '2013/10/10', end_day: '2013/10/10', total: -1.0 }

    before do
      allow(Date).to receive(:today).and_return(Date.today.beginning_of_year)
      martin.leaves << total_leave_in_last_year
      martin.leaves << leave_days_in_last_year_martin
      LeaveDays.add_leave_days_staff
    end

    context 'Add cumulative leave days for staff when new year comes' do
      it 'Add cumulative leave days for staff when new year comes' do
        expect(martin.leaves.count).to eq 6
        expect(martin.leaves.first.total).to eq 7
        expect(martin.leaves.first.sub_cate).to eq 'carry_over'
      end
    end
  end
end
