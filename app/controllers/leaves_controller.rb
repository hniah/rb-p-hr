class LeavesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @leaves = current_user.is_admin? ? Leave : current_staff.leaves
    @leaves = @leaves.paginate(page: page)
  end

  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.new(leave_param.merge(staff: current_staff))
    if @leave.save
      redirect_to leaves_path, notice: t('leave.message.create_success')
    else
      flash[:alert] = t('leave.message.create_failed')
      render :new
    end
  end

  protected
  def page
    params[:page]
  end

  def leave_param
    params.require(:leave).permit(:date, :kind, :reason_leave, :status, :note)
  end

  def current_staff
    current_user.becomes(Staff)
  end
end
