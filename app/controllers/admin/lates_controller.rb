class Admin::LatesController < AdminsController
  def new
    @late = Late.new
    render :new
  end

  def create
    @staff = Staff.find(staff_id)
    @late = @staff.lates.new(late_params)
    
    if @staff.save
      redirect_to admin_lates_url, notice: t('.message.success')
    else
      flash[:alert] = @staff.errors.full_messages.join('<br>')
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

  def staff_id
    params.require(:late).fetch(:staff_id, 0)
  end
end

