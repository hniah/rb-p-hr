class SystemNotifier < ActionMailer::Base
  default from: 'mailer@futureworkz.com'

  def notify(email, leave, subject, template)
    @leave = leave
    mail(to: email, subject: subject) do |format|
      format.html {render template}
    end
  end
end
