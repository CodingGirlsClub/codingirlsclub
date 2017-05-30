class UsersController < ApplicationController
  before_action :require_login, only: [:identity_selector, :edit]
  
  def edit
    @cities = City.provinces
  end
  
  def update
    @user = User.find params[:id]
    @cities = City.provinces
    if @user.update(user_params)
      flash[:notice] = "修改成功！"
      redirect_to edit_user_path(@user)
    else
      flash[:error] = "#{@user.errors.messages.values.join(", ")}"
      render :edit
    end
  end

  def create
    if params[:password] != params[:comfirm_password]
      flash[:error] = "两次密码验证不一致！"
      redirect_to action: :new, invite_code: params[:code]
    elsif !Cgc::Tools::Regular.match_email(params[:email])
      flash[:error] = "Email格式不正确！"
      redirect_to action: :new, invite_code: params[:code]
    elsif !(Token.verify_prefix_token(params[:email], params[:code]) or Token.verify_general_token(params[:code]))
      flash[:error] = "无效邀请码！"
      redirect_to action: :new, invite_code: params[:code]
    elsif params[:name].blank? or params[:email].blank? or params[:password].blank?
      flash[:error] = "请填写必须的项！"
      redirect_to action: :new, invite_code: params[:code]
    else
      user = User.new(name: params[:name], email: params[:email], password: params[:password])
      if user.save
        if params[:invite_email]
          lu = LatentUser.find_by email: params[:invite_email]
          lu.update_columns(active: true)
        end
        session[:user_id] = user.id
        redirect_to root_path
        UserMailer.welcome_email(@user).deliver_later
      else
        redirect_to action: :new
      end
    end
  end

  def identity_selector
    @cities = City.provinces
    if request.patch?
      if params[:user][:casting].to_i == User::CASTING_LEARNER and params[:user][:id_photo].blank?
        flash[:error] = "学生请上传学生证！"
        Rails.logger.info "====== falsh: #{flash.inspect}"
        render :identity_selector
      elsif params[:user][:casting].blank? or params[:user][:city_id].blank? or params[:user][:gender].blank? or params[:user][:casting].blank?
        flash[:error] = "请选择所有选项！"
        Rails.logger.info "====== falsh: #{flash.inspect}"
        render :identity_selector
      elsif !User.valid_gender?(params[:user][:gender]) or !User.valid_casting?(params[:user][:casting]) or !City.vaid_city_id?(params[:user][:city_id])
        flash[:error] = "您的选择不合法！"
        render :identity_selector
      else
        user = User.find params[:id]
        user.attributes = identity_selector_params.merge!(casting_check: User::CASTING_CHECKING)
        if user.update(identity_selector_params)
          redirect_to root_path
        else
          flash[:error] = "提交失败！"
          render :identity_selector
        end
      end
    end
  end

  def access_invite_code
    if request.post?
      if !Cgc::Tools::Regular.match_email(params[:email])
        flash[:error] = "请输入合法的Email!"
        render :access_invite_code
      else
        if @latent_user = LatentUser.create(email: params[:email])
          flash[:notice] = "您的申请已提交，邀请码会在一个工作日内发到您的邮箱里!"
          redirect_to root_path
        else
          render :access_invite_code
        end
      end
    end
    
  end

  def access_campus_ambassador
    @qa = AmbassadorQa.applied_qa
    if request.post?
      Ambassador.create(user_id: current_user.id, title: params[:ambassador_title])
      params[:answers].first.each do |k, v|
        Answer.create(question_id: k, content: v, user_id: current_user.id)
      end
      flash[:notice] = "您已提交申请，会由管理员主动联系你！"
      redirect_to root_path
    end
  end

  def forget_password
    email = params[:email]
    if request.post?
      if !Cgc::Tools::Regular.match_email(email)
        flash[:error] = "Email格式不正确！"
        render :forget_password
      else
        if @user = User.find_by_email(params[:email])
          token = Token.generate(prefix: email, type: :chars, size: 8, period: 1.hour)
          UserMailer.reset_password(email, token.name.split(":").last).deliver_later
          flash[:notice] = "您的密码重置邮件已发出，请查收！"
          redirect_to login_path
        else
          flash[:error] = "无此帐号！"
          render :forget_password
        end
      end
    end
  end

  def reset_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if params[:password] != params[:comfirm_password]
        flash[:error] = "两次密码验证不一致！"
        redirect_to action: :reset_password, email: params[:email], token: params[:token]
      else
        if Token.verify_prefix_token(params[:email], params[:token])
          if @user.update(password: params[:password])
            flash[:notice] = "密码重置成功，请登录！"
            redirect_to login_path
          else
            flash[:error] = "密码重置失败！"
            redirect_to action: :reset_password, email: params[:email], token: params[:token]
          end
        else
          flash[:error] = "无效验证码！"
          redirect_to login_path
        end
      end
    end
  end
  
  
  private
  def identity_selector_params
    params.require(:user).permit(:city_id, :gender, :id_photo, :age_range, :casting, :description)
  end

  def user_params
    params.require(:user).permit(:full_name, :mobile, :intro, :city_id, :gender, :avatar, :age_range, :github_url, :wechat_id)
  end
end
