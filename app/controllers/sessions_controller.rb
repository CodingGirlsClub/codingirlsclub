class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:email])
      redirect_to root_path
    else
      flash.now[:danger] = '无效的Email或密码'
      render :new
    end
  end

  def destroy
  end
end
