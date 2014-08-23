class Admin::LeavesController < AdminsController

  def approve
    @leave = Leave.find(leave_id)
    if @leave.update(status: :approved)
      # Notify Staff when leave is approved
      LeaveNotifier.approved(@leave).deliver
      redirect_to leaves_path, notice: t('leave.message.approve_leave')
    else
      flash[:alert] = t('leave.message.update_failed')
      redirect_to leaves_path
    end
  end

  def reject
    @leave = Leave.find(leave_id)
  end

  def reject_action
    @leave = Leave.find(leave_id)
    if @leave.update(leave_param.merge(status: :rejected))
      # Notify Staff when leave is rejected
      LeaveNotifier.rejected(@leave).deliver
      redirect_to leaves_path, notice: t('leave.message.reject_leave')
    else
      flash[:alert] = t('leave.message.update_failed')
      redirect_to leaves_path
    end
  end

  protected
  def leave_id
    params.require(:id)
  end

  def leave_param
    params.require(:leave).permit(:rejection_note)
  end
end
