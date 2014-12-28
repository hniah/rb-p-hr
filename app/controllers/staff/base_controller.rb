class Staff::BaseController < LoggedInController
  protected
  def current_staff
    current_user.becomes(Staff)
  end
end
