class LeavesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @leaves = current_user.is_admin? ? Leave : current_staff.leaves
    @leaves = @leaves.paginate(page: page)
  end

  protected
  def page
    params[:page]
  end

  def current_staff
    current_user.becomes(Staff)
  end
end
