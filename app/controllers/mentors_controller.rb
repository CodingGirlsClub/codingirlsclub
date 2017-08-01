class MentorsController < ApplicationController
  before_action :login_required,    only: [:new, :create]
  before_action :no_apply_required, only: [:new, :create]

  def index
    @mentors = Mentor.where(status: 'status_success')
  end

  def new
    @mentor = Mentor.new
  end

  def create
    @mentor = Mentor.new(mentor_params)
    if @mentor.save
      flash[:success] = '您已提交申请，会由管理员主动联系你！'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def mentor_params
    params.require(:mentor).permit(:user_id, :introduce_self, :why_to_teach, :master_lang, :city_id, :teaching_time, :phone_number, :wechat_id, :github_url, :ever_project_url, :resume_url, course_ids: [])
  end

  def no_apply_required
    if Mentor.exists?(user_id: current_user.id)
      flash[:danger] = '申请还在处理中或申请已通过，不可以重复申请'
      redirect_to root_path
    end
  end
end
