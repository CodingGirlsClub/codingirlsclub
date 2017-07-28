module Cgc
  class QasController < BaseController
    before_action :set_qa, only: [:show, :enabled, :disabled]

    def index
      @search = Qa.ransack(params[:q])
      @qas       = @search.result.order(id: :desc).page(params[:page]).per(20)
      @qas_count = @qas.count
    end

    def show
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
  end
end
