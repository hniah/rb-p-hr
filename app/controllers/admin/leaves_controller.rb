class Admin::LeavesController < Admin::BaseController

  def index
    @leaves = Leave.all

    if params['status'] == 'pending'
      @leaves = @leaves.pending
    end
    @sort_column = sort_column
    @sort_direction = sort_direction

    @leaves = @leaves.order(@sort_column => @sort_direction)
    @leaves = @leaves.paginate(page: page)
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
      LeaveNotifier.warning_sick_leave(@leave).deliver if @leave.amount_sick_date > 7
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
    params.fetch(:page, 1).to_i
  end

  def leave_id
    params.require(:id)
  end

  def leave_reject_param
    params.require(:leave).permit(:rejection_note)
  end

  def leave_param
    params.require(:leave).permit(
      :reason, :staff_id, :category, :start_date, 
      :end_date, :start_time, :end_time, :total_value, 
      :reason_note, :status, :sub_cate, emails_cc:[]
    )
  end

  def sort_column
    params.fetch(:sort_column, 'start_day').to_sym
  end

  def sort_direction
    params.fetch(:sort_direction, 'desc').to_sym
  end
end
