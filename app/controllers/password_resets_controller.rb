class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = '找回密码邮件已发送，请查收邮件'
      redirect_to root_path
    else
      flash.now[:danger] = 'Email未注册'
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, '不能为空')
      render :edit
    elsif @user.update_attributes(user_params)
      login(@user)
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = '密码重置成功'
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 用户合法性
  def valid_user
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_path
    end
  end

  # 检查 reset token 是否已过期
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = '重置密码链接已失效'
      redirect_to new_password_reset_path
    end
  end
end
