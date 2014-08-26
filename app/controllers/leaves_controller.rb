class LeavesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @leaves = current_staff.leaves.paginate(page: page)
  end

  def new
    @leave = Leave.new
    1.times { @leave.leave_days.build }
  end

  def create
    @leave = Leave.new(leave_param.merge(staff: current_staff))
    if @leave.save
      # Notify HR when new leave come
      LeaveNotifier.new_leave(@leave).deliver
      redirect_to leaves_path, notice: t('leave.message.create_success')
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
    params.require(:leave).permit(:reason, :staff_id, :category, leave_days_attributes: [ :date, :kind, :id, :_destroy ])
  end

  def current_staff
    current_user.becomes(Staff)
  end
end
