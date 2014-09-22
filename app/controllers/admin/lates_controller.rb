class Admin::LatesController < Admin::BaseController

  def index
    @lates = Late.all
    render :index
  end

  def new
    @late = Late.new
    render :new
  end

  def create
    @late = Late.new(late_params)

    if @late.save
      LateNotifier.more_late(@late).deliver if @late.staff.lates.in_year(@late.date.year).size >= 10
      redirect_to admin_lates_url, notice: t('.message.success')
    else
      flash[:alert] = @late.errors.full_messages.join('<br>')
      render :new
    end
  end

  def edit
    @late = Late.find(late_id)
    render :edit
  end

  def update
    @late = Late.find(late_id)

    if @late.update(late_params)
      redirect_to admin_lates_url, notice: t('.message.success')
    else
      render :edit, failure: t('.message.failure')
    end
  end

  def destroy
    @late = Late.find late_id

    if @late.destroy!
      flash[:notice] = t('.message.success')
    else
      flash[:alert] = t('.message.failure')
    end

    redirect_to admin_lates_url
  end

  def show
    @late = Late.find late_id
    @versions = @late.versions
  end

  protected
  def late_params
    params.require(:late).permit(:note, :staff_id, :date)
  end


  def late_id
    params.require(:id)
  end
end

