class SystemNotifier < ActionMailer::Base
  default(
    from: "Futureworkz Human Resources #{ENV['EMAIL_DEFAULT_FROM']}",
    reply_to: 'Futureworkz Human Resource hr@futureworkz.com'
  )
 
end
