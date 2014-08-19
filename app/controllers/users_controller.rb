class UsersController < ApplicationController
  expose(:user)

  def index
    @users = User.paginate(page: page)
  end

  def create
    @user = User.new(user_param)
    if @user.save
      redirect_to users_path, notice: t('user.message.create_success')
    else
      flash[:alert] = t('user.message.create_failed')
      render :new
    end
  end

  def update
    @staff = User.find(user_id)
    if @staff.update(user_param)
      redirect_to users_path, notice: t('user.message.update_success')
    else
      flash[:alert] = t('user.message.update_failed')
      render :edit
    end
  end

  def destroy
    @user = User.find(user_id)
    if @user.destroy
      redirect_to users_path, notice: t('user.message.delete_success')
    else
      flash[:alert] = t('user.message.delete_failed')
      render :index
    end
  end

  def show
    @user = User.find(user_id)
  end

  protected
  def page
    params[:page]
  end

  def user_id
    params.require(:id)
  end

  def user_param
    params.require(:user).permit(:email, :name, :english_name, :personal_email, :address, :birthday, :note, :social_insurance, :phone_number, :basic_salary, :pay_increment, :started_on, :probation_end_on, :password, :password_confirmation)
  end

end
