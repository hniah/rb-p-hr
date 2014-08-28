class Staff::LatesController < Staff::BaseController
  def index
    @staff = current_staff
    @lates = @staff.lates.paginate(page: page)
    render :index
  end

  protected
  def page
    params[:page]
  end
end

