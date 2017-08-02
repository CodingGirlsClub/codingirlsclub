class AmbassadorsController < ApplicationController
  before_action :login_required,              only: [:new, :create]
  before_action :university_student_required, only: [:new, :create]
  before_action :no_apply_required,           only: [:new, :create]
  before_action :set_ambassador_qa,           only: [:new, :create]

  def index
    @ambassadors = Ambassador.where(status: 'status_success')
  end

  def new
    @ambassador = Ambassador.new
  end

  def create
    dup_ambassador_params                 = ambassador_params
    dup_ambassador_params[:qa_id]         = @qa.id
    dup_ambassador_params[:city_id]       = current_user.city_id
    dup_ambassador_params[:university_id] = current_user.university_id
    @ambassador = Ambassador.new(dup_ambassador_params)
    submit_answers_hash = params[:answers].first
    question_id_num     = submit_answers_hash.keys.length
    contents_num        = submit_answers_hash.values.reject { |content| content.blank? }.length
    # 问题 id 数量与存在内容的 answer content 内容不一致，即代表存在未回答的问题
    if question_id_num != contents_num
      flash[:danger] = '所有问题都需要被回答'
      render :new
    elsif @ambassador.save
      params[:answers].first.each do |question_id, content|
        Answer.create!(question_id: question_id, content: content, user_id: current_user.id)
      end
      flash[:success] = '您已提交申请，会由管理员主动联系你！'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def ambassador_params
    params.require(:ambassador).permit(:user_id, :self_introduction, :resume_url, :qa_id, :university_id, :city_id)
  end

  def set_ambassador_qa
    @qa = Qa.where(category: 'AmbassadorQa', status: 'status_enabled').order(id: :desc).first
    if @qa.nil?
      flash[:danger] = '暂时无法申请，请等待题目开放'
      redirect_to root_path
    end
  end

  def university_student_required
    unless current_user.is_university_student? || current_user.id_photo_status_success? # 在校大学生且学生证审核通过才可申请校园大使
      flash[:danger] = '只有在校大学生才可申请校园大使'
      redirect_to root_path
    end
  end

  def no_apply_required
    if Ambassador.exists?(user_id: current_user.id)
      flash[:danger] = '申请还在处理中或申请已通过，不可以重复申请'
      redirect_to root_path
    end
  end
end
