class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail(to: user.email, subject: I18n.t('Verify Your Account'))
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: I18n.t('Retrieve Password'))
  end
end