class Admin::LatesController < AdminsController
  def new
    @late = Late.new
    render :new
  end

  def create
    @late = Late.new(late_params)
    
    if @late.save
      redirect_to admin_lates_url, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :new
    end
  end

  def index
    @lates = Late.all
    render :index
  end

  protected
  def late_params
    params.require(:late).permit(:note, :staff_id)
  end
end

