class ApplicationMailer < ActionMailer::Base
  default from: ENV['SUBMAIL_FROM']
  layout 'mailer'
end
