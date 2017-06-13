ActionMailer::Base.delivery_method = :smtp

# MySubMail Config
ActionMailer::Base.smtp_settings = {
  address:              'cloud.submail.cn',
  port:                 25,
  domain:               'mail.codingirls.club',
  user_name:            ENV['SUBMAIL_USERNAME'],
  password:             ENV['SUBMAIL_PASSWORD'],
  authentication:       :plain,
  enable_starttls_auto: true
}
