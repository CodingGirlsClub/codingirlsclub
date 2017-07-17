module Cgc
  class SessionsController < BaseController
    skip_before_action :require_admin_login

    def new
    end

    def create
      admin = Admin.find_by(email: params[:session][:email].downcase)
      if admin && admin.authenticate(params[:session][:password])
        login(admin)
        flash[:success] = '登录成功'
        redirect_to root_path
      else
        flash.now[:danger] = '无效的Email或密码'
        render :new
      end
    end

    def destroy
      logout if admin_logined?
      redirect_to login_path
    end
  end
end
