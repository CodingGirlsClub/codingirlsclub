module Cgc
  class QuestionsController < BaseController
    before_action :set_qa

    def index
      @questions = @qa.questions.order(id: :desc)
    end

    def create
      @question = @qa.questions.build(question_params)
      if @question.save
        redirect_to qa_questions_path(@qa)
      else
        render :index
      end
    end

    def destroy
      @question = Question.find(params[:id])
      @success  = @question.destroy

      respond_to do |format|
        format.js
      end
    end

    private

    def set_qa
      @qa = Qa.find(params[:qa_id])
    end

    def question_params
      params.require(:question).permit(:title)
    end
  end
end
