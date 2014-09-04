class Admin::Staffs::VersionsController < Admin::BaseController
  def index
    @staff = Staff.find(staff_id)
    @versions = @staff.versions.paginate(page: page)
  end

  protected
  def page
    params[:page]
  end

  def staff_id
    params.require(:staff_id)
  end

end
