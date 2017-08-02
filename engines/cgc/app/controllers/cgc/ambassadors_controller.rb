module Cgc
  class AmbassadorsController < BaseController
    before_action :set_ambassador, only: [:show, :do_status_success, :do_status_failed]

    def index
      # 回填城市搜索内容
      if params[:q] && params[:q][:city_id_eq].present?
        @city_default_value = [City.find_by(id: params[:q][:city_id_eq])&.province, params[:q][:city_id_eq]]
      end

      # 回填学校搜索内容
      if params[:q] && params[:q][:city_id_eq].present? && params[:q][:university_id_eq].present?
        @university_default_value = [University.find_by(id: params[:q][:university_id_eq])&.name, params[:q][:university_id_eq]]
      end

      @search            = Ambassador.ransack(params[:q])
      @ambassadors       = @search.result.includes(user: [:city, :university]).order(id: :desc).page(params[:page]).per(20)
      @ambassadors_count = @search.result.count
    end

    def show
      qa                  = Qa.find_by(id: @ambassador.qa_id)
      answers_content_arr = Answer.where(user_id: @ambassador.user_id, question_id: qa.questions.map(&:id)).map(&:content)
      @answers            = qa.questions.map(&:title).zip(answers_content_arr)
    end

    # 以动态方法定义校园大使审核相应的方法
    methods_name = [:do_status_success, :do_status_failed]
    methods_name.each do |method_name|
      define_method method_name do
        @success = @ambassador.send("#{method_name}!") if @ambassador.send("may_#{method_name}?")
        respond_to do |format|
          format.html { redirect_to action: :index }
          format.js { render 'operate' }
        end
      end
    end

    private

    def set_ambassador
      @ambassador = Ambassador.find(params[:id])
    end
  end
end
