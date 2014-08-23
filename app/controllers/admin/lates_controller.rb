class Admin::LatesController < AdminsController
  def new
    @late = Late.new
    render :new
  end

  def create
    @late = Late.new(late_params.merge(staff: current_user.becomes(Staff)))
    
    if @late.save!
      redirect_to root_path, notice: t('.message.success')
    else
      render :new
    end
  end

  def index
    @lates = Late.all
  end

  protected
  def late_params
    params.require(:late).permit(:note)
  end
end

