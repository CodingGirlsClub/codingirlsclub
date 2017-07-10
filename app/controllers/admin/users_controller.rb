class Admin::UsersController < Admin::BaseController
  def show
    @user = User.find params[:id]
  end

  def approved
    @user = User.find params[:id]
    @user.update(casting_check: User::CASTING_PASS)
    respond_to do |f|
      f.html { redirect_to admin_user_path(@user) }
      f.js
    end
    
  end

  def unapproved
    @user = User.find params[:id]
    @user.update(casting_check: User::CASTING_REFUSE)
    respond_to do |f|
      f.html { redirect_to admin_user_path(@user) }
      f.js
    end
  end

  def general_tokens
    @tokens = Token.general_tokens.page(params[:page]).per(10)
  end

  def gen_general_token
    10.times do
      Token.generate(prefix: "_", type: :chars, size: 8, period: 1.day, general: true) 
    end
    redirect_to general_tokens_admin_users_path
  end
  
  
end