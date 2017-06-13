class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(to: user.email, subject: '帐号激活')
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: '找回密码')
  end
end
