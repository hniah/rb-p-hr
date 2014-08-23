class FeedbackNotifier < SystemNotifier

  def new_feedback(feedback)
    @feedback = feedback
    mail(to: ENV['FEEDBACK_RECEIVERS'], subject: '[HR System] New feedback from user') do |format|
      format.html { render 'notifier/feedback/new' }
    end
  end
end
