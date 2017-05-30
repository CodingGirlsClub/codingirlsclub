class Admin::SessionsController < Admin::BaseController
  skip_before_action :require_admin_login

  def create
    if !::Cgc::Tools::Regular.match_email(params[:email])
      flash[:alert] = "Email格式不正确！"
      render :new
    elsif params[:email].blank? or params[:password].blank?
      flash[:alert] = "请填写正确的登录帐号和密码！"
      render :new
    else
      admin = Admin.find_by(email: params[:email])
      if admin and admin.authenticate(params[:password])
        session[:admin_id] = admin.id
        redirect_to admin_root_path
      else
        flash[:alert] = "用户名和密码错误"
        render :new
      end
    end
  end

  def destroy
    reset_session
    redirect_to admin_login_path
  end
end