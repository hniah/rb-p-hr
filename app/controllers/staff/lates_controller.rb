class Staff::LatesController < Staff::BaseController
  def index
    @staff = current_staff
    @lates = @staff.lates
  end
end

