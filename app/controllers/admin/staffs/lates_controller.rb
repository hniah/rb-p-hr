class Admin::Staffs::LatesController < AdminsController

  def index
    @staff = Staff.find(staff_id)
    @lates = @staff.lates.paginate(page: page)
    render :index
  end

  protected
  def staff_id
    params.require(:staff_id)
  end

  def page
    params[:page]
  end
end

