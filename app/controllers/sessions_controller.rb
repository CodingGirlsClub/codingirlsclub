class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login(user)
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:success] = '登录成功'
      else
        flash[:warning] = '帐号还没有激活，请激活帐号'
      end
      redirect_to root_path
    else
      flash.now[:danger] = '无效的Email或密码'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
