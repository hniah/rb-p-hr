class Admin::LeavesController < AdminsController

  def index
    @leaves = Leave.pending.paginate(page: page)
  end

  def new
    @leave = Leave.new
    1.times { @leave.leave_days.build }
  end

  def create
    @leave = Leave.new(leave_param)
    if @leave.save
      # Notify HR when new leave come
      LeaveNotifier.new_leave(@leave).deliver
      redirect_to admin_leaves_path, notice: t('leave.message.create_success')
    else
      flash[:alert] = t('leave.message.create_failed')
      render :new
    end
  end

  def edit
    @leave = Leave.find(leave_id)
  end

  def update
    @leave = Leave.find(leave_id)
    if @leave.update(leave_param)
      redirect_to admin_leaves_path, notice: t('leave.message.update_success')
    else
      flash[:alert] = t('leave.message.update_failed')
      render :edit
    end
  end

  def destroy
    @leave = Leave.find(leave_id)
    if @leave.destroy
      redirect_to admin_leaves_path, notice: t('leave.message.delete_success')
    else
      flash[:alert] = t('leave.message.create_failed')
      render :index
    end
  end

  def approve
    @leave = Leave.find(leave_id)
    if @leave.update(status: :approved)
      # Notify Staff when leave is approved
      LeaveNotifier.approved(@leave).deliver
      redirect_to admin_leaves_path, notice: t('leave.message.approve_leave')
    else
      flash[:alert] = t('leave.message.update_failed')
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
      redirect_to admin_leaves_path, notice: t('leave.message.reject_leave')
    else
      flash[:alert] = t('leave.message.update_failed')
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
    params.require(:leave).permit(:reason, :staff_id, :category, leave_days_attributes: [ :date, :kind, :id, :_destroy ])
  end
end
