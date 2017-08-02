module Cgc
  class QasController < BaseController
    before_action :set_qa, only: [:show, :do_status_enabled, :do_status_disabled]
    before_action :set_status_fresh_qa, only: [:edit, :update]

    def index
      @search = Qa.ransack(params[:q])
      @qas       = @search.result.order(id: :desc).page(params[:page]).per(20)
      @qas_count = @qas.count
    end

    def show
    end

    def new
      @qa = Qa.new
    end

    def create
      @qa = Qa.new(qa_params)
      if @qa.save
        redirect_to qa_questions_path(@qa)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @qa.update_attributes(qa_params)
        redirect_to qas_path
      else
        render :edit
      end
    end

    # 运用动态方法定义状态相应方法
    method_names = [:do_status_enabled, :do_status_disabled]
    method_names.each do |method_name|
      define_method method_name do
        @success = @qa.send("#{method_name}!") if @qa.send("may_#{method_name}?")
        respond_to do |format|
          format.html { redirect_to action: :index }
          format.js { render 'operate' }
        end
      end
    end

    private

    def set_qa
      @qa = Qa.find(params[:id])
    end

    # 只有草稿状态的问题才可编辑
    def set_status_fresh_qa
      @qa = Qa.find_by!(id: params[:id], status: 'status_fresh')
    end

    def qa_params
      params.require(:qa).permit(:title, :description, :category)
    end
  end
end
