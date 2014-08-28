class LatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @lates = current_staff.lates.paginate(page: page)
    render :index
  end

  protected
  def page
    params[:page]
  end

  def current_staff
    current_user.becomes(Staff)
  end
end

