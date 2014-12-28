class LoggedInController < ApplicationController
  before_filter :authenticate_user!
  layout 'logged_in'

  def dashboard;end

  def help
    render :help
  end
end
