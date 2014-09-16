class Staff::LeavesController < Staff::BaseController
  def index
    @leaves = current_staff.leaves.paginate(page: page)
  end

  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.new(leave_param.merge(staff: current_staff))
    if @leave.save
      # Notify HR when new leave come
      LeaveNotifier.new_leave(@leave).deliver
      redirect_to staff_leaves_path, notice: t('leave.message.create_success')
    else
      flash[:alert] = t('leave.message.create_failed')
      render :new
    end
  end

  def show
    @leave = Leave.find(leave_id)
  end

  protected
  def page
    params[:page]
  end

  def leave_id
    params.require(:id)
  end

  def leave_param
    data = params.require(:leave).permit(:reason, :staff_id, :category, :start_day, :end_day, :start_time, :end_time, :total)
    data[:start_day] += ' ' + params[:leave].fetch(:start_time)
    data[:end_day] += ' ' + params[:leave].fetch(:end_time)
    @total = 0.5
    if params[:leave].fetch(:total).to_i > 0
      @total = -1 * params[:leave].fetch(:total).to_f
    end
    data[:total] = @total
    data
  end
end
