class Staff::BaseController < ApplicationController
  before_filter :authenticate_user!

  protected
  def current_staff
    current_user.becomes(Staff)
  end
end
