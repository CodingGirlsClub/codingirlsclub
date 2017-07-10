class Settings::ProfilesController < ApplicationController
  before_action :set_user

  def show
    @user.referral
    @city = City.find_by(id: @user.city_id)
    @university = University.find_by(id: @user.university_id)
  end

  def update
    dup_user_params = user_params.dup
    # 是在校大学生改为否，学校与学生证清空
    if @user.is_university_student? && user_params[:is_university_student] == 'false'
      dup_user_params[:university_id] = nil
      @user.remove_id_photo!
    end

    if @user.update_attributes(dup_user_params)
      flash[:success] = I18n.t 'Update Profile Successfully'
      redirect_to settings_profile_path
    else
      render :show
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :full_name, :mobile, :introduction, :city_id, :gender, :avatar, :age_range, :github_url, :wechat_id, :is_university_student, :university_id, :id_photo)
  end
end
