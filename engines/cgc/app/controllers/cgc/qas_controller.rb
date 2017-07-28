module Cgc
  class QasController < BaseController
    before_action :set_qa, only: [:show, :edit, :update, :enabled, :disabled]

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

    def enabled
      @success = @qa.update_attribute(:applied, true)
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.js { render 'operate' }
      end
    end

    def disabled
      @success = @qa.update_attribute(:applied, false)
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.js { render 'operate' }
      end
    end

    private

    def set_qa
      @qa = Qa.find(params[:id])
    end

    def qa_params
      params.require(:qa).permit(:title, :description, :category)
    end
  end
end
