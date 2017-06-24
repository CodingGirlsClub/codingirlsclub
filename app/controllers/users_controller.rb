class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      ActiveRecord::Base.transaction do
        @user.save!
        @user.generate_referral_with(params[:user][:promo_code])
      end
      flash[:success] = I18n.t('Registered Successfully')
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :promo_code)
  end
end
