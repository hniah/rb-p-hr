class SystemNotifier < ActionMailer::Base
  default from: "Futureworkz Human Resources #{ENV['EMAIL_DEFAULT_FROM']}"
end
