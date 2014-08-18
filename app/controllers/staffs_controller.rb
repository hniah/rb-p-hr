class StaffsController < ApplicationController
  expose(:staff)

  def index
    @staffs = Staff.paginate(page: page)
  end

  protected
  def page
    params[:page]
  end

end
