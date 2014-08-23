class Admin::FeedbacksController < AdminsController
  def index
    @feedbacks = Feedback.paginate(page: page)
  end

  protected
  def page
    params[:page]
  end
end
