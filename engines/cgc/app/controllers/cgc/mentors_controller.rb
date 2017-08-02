module Cgc
  class MentorsController < BaseController
    before_action :set_mentor, only: [:show, :do_status_success, :do_status_failed]

    def index
      # 回填城市搜索内容
      if params[:q] && params[:q][:city_id_eq].present?
        @city_default_value = [City.find_by(id: params[:q][:city_id_eq])&.province, params[:q][:city_id_eq]]
      end

      @search        = Mentor.ransack(params[:q])
      @mentors       = @search.result.includes(:city, :user).order(id: :desc).page(params[:page]).per(20)
      @mentors_count = @search.result.count
    end

    def show
    end

    # 以动态方法定义助教审核相应的方法
    methods_name = [:do_status_success, :do_status_failed]
    methods_name.each do |method_name|
      define_method method_name do
        @success = @mentor.send("#{method_name}!") if @mentor.send("may_#{method_name}?")
        respond_to do |format|
          format.html { redirect_to action: :index }
          format.js { render 'operate' }
        end
      end
    end

    private

    def set_mentor
      @mentor = Mentor.find(params[:id])
    end
  end
end
