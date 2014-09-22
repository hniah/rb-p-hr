require 'rails_helper'

describe Late do
  context 'validations' do
    it { is_expected.to validate_presence_of :staff }
    it { is_expected.to validate_presence_of :staff_id }
    it { is_expected.to validate_presence_of :date }
  end

  context 'associations' do
    it { is_expected.to belong_to :staff }
  end

  describe 'get all late in current year' do
    context 'get all late in current year' do
      let!(:lates_current_year) { create_list :late, 2, date: Date.today }
      let!(:lates_last_year) { create_list :late, 2, date: '2013/03/03'}

      it 'get all late in current year' do
        expect(Late.current_year.size).to eq 2
      end
    end
  end

  describe 'get all late in year' do
    context 'get all late in year' do
      let!(:lates_current_year) { create_list :late, 2, date: Date.today }
      let!(:lates_last_year) { create_list :late, 2, date: '2013/03/03'}

      it 'get all late in year' do
        expect(Late.in_year(2013).size).to eq 2
      end
    end
  end


end

