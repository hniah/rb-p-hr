class Admin::StaffsController < AdminsController
  def index
    @users = User.paginate(page: page)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(staff_param)
    if @user.save
      redirect_to admin_staffs_path, notice: t('staff.message.create_success')
    else
      flash[:alert] = t('staff.message.create_failed')
      render :new
    end
  end

  def edit
    @user = User.find(staff_id)
  end

  def update
    @staff = User.find(staff_id)
    if @staff.update(staff_param)
      redirect_to admin_staffs_path, notice: t('staff.message.update_success')
    else
      flash[:alert] = t('staff.message.update_failed')
      render :edit
    end
  end

  def destroy
    @user = User.find(staff_id)
    if @user.destroy
      redirect_to admin_staffs_path, notice: t('staff.message.delete_success')
    else
      flash[:alert] = t('staff.message.delete_failed')
      render :index
    end
  end

  def show
    @user = User.find(staff_id)
  end

  protected
  def page
    params[:page]
  end

  def staff_id
    params.require(:id)
  end

  def staff_param
    params.require(:staff).permit(:email, :name, :english_name, :personal_email, :address, :birthday, :note, :social_insurance, :phone_number, :started_on, :probation_end_on, :password, :password_confirmation, :designation, :is_admin)
  end
end
