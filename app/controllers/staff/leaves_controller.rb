class Staff::LeavesController < Staff::BaseController
  def index
    @leaves = current_staff.leaves.order(start_day: :desc).paginate(page: page)
  end

  def new
    @leave = Leave.new
    @leader = User.find(current_staff.leader) if current_staff.leader.presence
  end

  def create
    @leave = Leave.new(leave_param.merge(staff: current_staff))

    if @leave.save
      LeaveNotifier.new_leave(@leave).deliver
      redirect_to staff_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
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
    params.require(:leave).permit(:reason, :category, :start_date, :end_date, :start_time, :end_time, :total_value, :reason_note, emails_cc:[])
  end
end
