class HrNotifier < ActionMailer::Base
  default from: 'no-reply@example.com'

  def leave_come(email, leave)
    @leave = leave
    mail(to: email,
        subject: 'New Leave Application') do |format|
      format.html {render 'notifier/hr_notifier'}
    end
  end
end
