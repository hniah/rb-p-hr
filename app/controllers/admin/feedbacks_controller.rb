class Admin::FeedbacksController < Admin::BaseController
  def index
    @feedbacks = Feedback.paginate(page: page)
  end

  protected
  def page
    params[:page]
  end
end
