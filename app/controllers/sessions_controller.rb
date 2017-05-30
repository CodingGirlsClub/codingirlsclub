class SessionsController < ApplicationController

  def create
    if !Cgc::Tools::Regular.match_email(params[:email])
      flash[:error] = "Email格式不正确！"
      render :new
    elsif params[:email].blank? or params[:password].blank?
      flash[:error] = "请填写正确的登录帐号和密码！"
      render :new
    else
      user = User.find_by(email: params[:email])
      if user and user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path
      else
        flash[:error] = "用户名和密码错误"
        render :new
      end
    end
  end

  def token_login
    if request.post?
      if Token.verify_prefix_token(params[:email], params[:token])
        user = User.find_by(email: params[:email])
        session[:user_id] = user.id
        flash[:notice] = "登录成功！"
        redirect_to root_path
      else
        flash[:error] = "无效验证码！"
        redirect_to root_path
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
