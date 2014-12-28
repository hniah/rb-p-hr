class Admin::BaseController < LoggedInController
  before_filter :authenticate_admin!

  def authenticate_admin!
    unless current_user.is_admin?
      redirect_to root_path, alert: 'You are not allowed to visit this page'
    end
  end

  protected
  def current_admin
    current_user.becomes(Admin)
  end
end

