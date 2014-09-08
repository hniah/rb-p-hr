class Admin::SettingsController < Admin::BaseController
  def index
    @settings = Setting.paginate(page: page)
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_param)
    if @setting.save
      redirect_to admin_settings_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :new
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
