class AnnualsController < ApplicationController
  def add_annual_leave_days
    LeaveDays.add_annual_sick_leave_days
    render json: 'DONE'
  end
end
