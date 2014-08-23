class SystemNotifier < ActionMailer::Base
  default from: ENV['EMAIL_DEFAULT_FROM']
end
