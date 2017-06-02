class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login(user)
      flash[:success] = '帐号激活成功'
      redirect_to settings_profile_path
    else
      flash[:danger] = '无效的激活链接'
      redirect_to root_path
    end
  end
end
