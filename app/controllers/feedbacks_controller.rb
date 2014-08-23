class FeedbacksController < ApplicationController
  before_filter :authenticate_user!

  def new
    @feedback = Feedback.new
    render :new
  end

  def create
    @feedback = Feedback.new(feedback_params.merge(staff: current_user.becomes(Staff)))

    if @feedback.save
      redirect_to root_path, notice: 'Thanks for your submission'
    else
      flash[:alert] = t('.message.failure')
      render :new
    end
  end

  protected
  def feedback_params
    params.require(:feedback).permit(:kind, :content)
  end
end
