class Admin::LeavesController < Admin::BaseController

  def index
    @leaves = Leave.pending.paginate(page: page)
  end

  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.new(leave_param)
    if @leave.save
      # Notify HR when new leave come
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
    if @leave.update(leave_param)
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

  def approve
    @leave = Leave.find(leave_id)
    if @leave.update(status: :approved)
      # Notify Staff when leave is approved
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
      # Notify Staff when leave is rejected
      LeaveNotifier.rejected(@leave).deliver
      redirect_to admin_leaves_path, notice: t('.message.success')
    else
      flash[:alert] = t('.message.failure')
      redirect_to admin_leaves_path
    end
  end

  def show
    @leave = Leave.find(leave_id)
    @versions = @leave.versions
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
