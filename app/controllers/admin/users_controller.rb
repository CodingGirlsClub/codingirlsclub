class Admin::UsersController < Admin::BaseController
  def casting_check
    # @users = User.casting_check_list.page(params[:page]).per(10)
  end

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

  def latent_user_list
    @latent_users = LatentUser.order("created_at desc").page(params[:page]).per(1)
  end

  def gen_signup_link
    @latent_user = LatentUser.find params[:id]
    token = Token.generate(prefix: @latent_user.email, type: :chars, size: 8, period: 1.day)
    UserMailer.sent_invite_code(@latent_user.email, token.name.split(":").last).deliver_later
    @latent_user.update_columns(invited: true)

    respond_to do |f|
      f.html { redirect_to latent_user_list_admin_users_path }
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