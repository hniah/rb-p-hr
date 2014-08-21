class StaffsController < ApplicationController
  before_filter :authenticate_user!


  def show
    @staff = Staff.find(current_user)
  end

end
