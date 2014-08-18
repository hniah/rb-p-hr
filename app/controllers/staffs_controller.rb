class StaffsController < ApplicationController
  expose(:staff)

  def index
    @staffs = Staff.paginate(page: page)
  end

  def create
    @staff = Staff.new(staff_param)
    if @staff.save
      redirect_to staffs_path, notice: t('staff.message.create_success')
    else
      flash[:alert] = t('staff.message.create_failed')
      render :new
    end
  end

  protected
  def page
    params[:page]
  end

  def staff_param
    params.require(:staff).permit(:email, :name, :english_name, :personal_email, :address, :phone_number, :basic_salary, :started_on, :probation_end_on, :password, :password_confirmation)
  end

end
