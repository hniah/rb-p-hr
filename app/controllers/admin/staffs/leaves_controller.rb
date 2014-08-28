class Admin::Staffs::LeavesController < AdminsController

  def index
    @staff = Staff.find(staff_id)
    @leaves = @staff.leaves.paginate(page: page)
  end

  protected
  def page
    params[:page]
  end

  def staff_id
    params.require(:staff_id)
  end
end
