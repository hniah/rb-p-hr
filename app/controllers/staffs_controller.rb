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

  def update
    @staff = Staff.find(staff_id)
    if @staff.update(staff_param)
      redirect_to staffs_path, notice: t('staff.message.update_success')
    else
      flash[:alert] = t('staff.message.update_failed')
      render :edit
    end
  end

  def destroy
    @staff = Staff.find(staff_id)
    if @staff.destroy
      redirect_to staffs_path, notice: t('staff.message.delete_success')
    else
      flash[:alert] = t('staff.message.delete_failed')
      render :index
    end
  end

  def show
    @staff = Staff.find(staff_id)
  end

  protected
  def page
    params[:page]
  end

  def staff_id
    params.require(:id)
  end

  def staff_param
    params.require(:staff).permit(:email, :name, :english_name, :personal_email, :address, :birthday, :note, :social_insurance, :phone_number, :basic_salary, :pay_increment, :started_on, :probation_end_on, :password, :password_confirmation)
  end

end
