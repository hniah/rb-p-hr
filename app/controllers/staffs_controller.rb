class StaffsController < ApplicationController
  expose(:staff)

  before_filter :authenticate_user!

  def show
    @staff = Staff.find(staff_id)
  end

  protected
  def staff_id
    params.require(:id)
  end
end
