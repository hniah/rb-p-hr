class Admin::StaffsController < Admin::BaseController
  def index
    @staffs = Staff.paginate(page: page)
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_param)

    if @staff.save
      redirect_to admin_staffs_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :new
    end
  end

  def edit
    @staff = Staff.find(staff_id)
  end

  def update
    @staff = Staff.find(staff_id)

    if @staff.update(staff_param)
      redirect_to admin_staffs_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :edit
    end
  end

  def destroy
    @staff = Staff.find(staff_id)

    if @staff.destroy
      redirect_to admin_staffs_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :index
    end
  end

  def show
    @staff = Staff.find(staff_id)
    @leaves = @staff.leaves.limit(5)
    @lates = @staff.lates.limit(5)
    @versions = @staff.versions.limit(5)
  end

  protected
  def page
    params[:page]
  end

  def staff_id
    params.require(:id)
  end

  def staff_param
    params.require(:staff).permit(:email, :name, :english_name, :personal_email, :address, :birthday, :note, :social_insurance, :phone_number, :started_on, :probation_end_on, :password, :password_confirmation, :designation, :is_admin, :is_leader)
  end
end
