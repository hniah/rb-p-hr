class LoggedInController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  layout 'logged_in'

  def dashboard;end

  def help
    render :help
  end
end
