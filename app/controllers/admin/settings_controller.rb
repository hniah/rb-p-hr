class Admin::SettingsController < Admin::BaseController
  def index
    @settings = Setting.paginate(page: page)
    @setting = Setting.new
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_param)

    if @setting.save
      redirect_to admin_settings_path, notice: t('.message.success')
    else
      @settings = Setting.paginate(page: page)
      flash[:alert] = t('.message.failure')
      render :index
    end
  end

  def edit
    @setting = Setting.find(setting_id)
  end

  def update
    @setting = Setting.find(setting_id)

    if @setting.update(setting_param)
      redirect_to admin_settings_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :edit
    end
  end

  def destroy
    @setting = Setting.find(setting_id)

    if @setting.destroy
      redirect_to admin_settings_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :index
    end
  end

  protected
  def page
    params[:page]
  end

  def setting_id
    params.require(:id)
  end

  def setting_param
    params.require(:setting).permit(:key, :value)
  end
end
