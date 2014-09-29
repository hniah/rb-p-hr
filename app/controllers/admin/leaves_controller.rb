class Admin::LeavesController < Admin::BaseController

  def index
    @leaves = Leave.paginate(page: page)
    if params['status'] == 'pending'
      @leaves = Leave.pending.paginate(page: page)
    end
  end

  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.new(leave_param)

    if @leave.save
      LeaveNotifier.new_leave(@leave).deliver
      redirect_to admin_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :new
    end
  end

  def edit
    @leave = Leave.find(leave_id)
  end

  def update
    @leave = Leave.find(leave_id)
    @leave.attributes = leave_param

    if @leave.save
      redirect_to admin_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :edit
    end
  end

  def destroy
    @leave = Leave.find(leave_id)

    if @leave.destroy
      redirect_to admin_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      render :index
    end
  end

  def show
    @leave = Leave.find(leave_id)
    @versions = @leave.versions
  end

  def approve
    @leave = Leave.find(leave_id)

    if @leave.update(status: :approved)
      LeaveNotifier.approved(@leave).deliver
      redirect_to admin_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      redirect_to admin_leaves_path
    end
  end

  def reject
    @leave = Leave.find(leave_id)
  end

  def reject_action
    @leave = Leave.find(leave_id)

    if @leave.update(leave_reject_param.merge(status: :rejected))
      LeaveNotifier.rejected(@leave).deliver
      redirect_to admin_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      redirect_to admin_leaves_path
    end
  end

  protected
  def page
    params[:page]
  end

  def leave_id
    params.require(:id)
  end

  def leave_reject_param
    params.require(:leave).permit(:rejection_note)
  end

  def leave_param
    params.require(:leave).permit(:reason, :staff_id, :category, :start_date, :end_date, :start_time, :end_time, :total_value, :reason_note)
  end
end
