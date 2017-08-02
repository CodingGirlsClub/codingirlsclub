module Cgc
  class UsersController < BaseController
    before_action :set_user, only: [:show, :do_approve_success, :do_approve_failed]

    def index
      # 回填城市搜索内容
      if params[:q] && params[:q][:city_id_eq].present?
        @city_default_value = [City.find_by(id: params[:q][:city_id_eq])&.province, params[:q][:city_id_eq]]
      end

      # 回填学校搜索内容
      if params[:q] && params[:q][:city_id_eq].present? && params[:q][:university_id_eq].present?
        @university_default_value = [University.find_by(id: params[:q][:university_id_eq])&.name, params[:q][:university_id_eq]]
      end

      @search      = User.ransack(params[:q])
      @users       = @search.result.includes(:city, :university).order(id: :desc).page(params[:page]).per(20)
      @users_count = @search.result.count
    end

    def show
    end

    # 动态定义方法形式生成学生证件审核对应的动作
    method_names = [:do_approve_success, :do_approve_failed]
    method_names.each do |method_name|
      define_method method_name do
        @success = @user.send("#{method_name}!") if @user.send("may_#{method_name}?")
        respond_to do |format|
          format.html { redirect_to action: :index }
          format.js { render 'operate' }
        end
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
