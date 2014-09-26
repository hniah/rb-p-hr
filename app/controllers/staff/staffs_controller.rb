class Staff::StaffsController < Staff::BaseController
  def show
    @staff = Staff.find(current_user)
    @leaves = @staff.leaves.limit(5)
    @lates = @staff.lates.limit(5)
  end
end
