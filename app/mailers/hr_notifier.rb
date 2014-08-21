class HrNotifier < ActionMailer::Base
  default from: 'mailer@futureworkz.com'

  def leave_come(email, leave)
    @leave = leave
    mail(to: email,
        subject: 'New Leave Application') do |format|
      format.html {render 'notifier/hr_notifier'}
    end
  end
end
