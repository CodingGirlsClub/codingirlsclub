class Admin::AmbassadorsController < Admin::BaseController

  def index
    @ambassadors = Ambassador.all.page(params[:page]).per(10)
  end

  def show
    @qa = AmbassadorQa.applied_qa
    @ambassador = Ambassador.find params[:id]
    @answers =  Answer.where("user_id = ? and question_id in (?)", @ambassador.user_id, @qa.questions.map(&:id) )
    @answer_list = @qa.questions.map(&:title).zip(@answers.map(&:content))
  end
  

  def qa_list
    @qas = AmbassadorQa.all.page(params[:page]).per(10)
  end

  def create_qa
    @qa = AmbassadorQa.new
    @qa.questions.build
    if request.post?
      @qa = AmbassadorQa.new(ambassador_qa_params)
      if @qa.save
        redirect_to  show_qa_admin_ambassador_path(@qa)
      else
        render :create_qa
      end

    end
  end

  def show_qa
    @qa = AmbassadorQa.find params[:id]
  end

  def apply_qa
    @qa = AmbassadorQa.find params[:id]
    @qa.update(applied: true)
    respond_to do |f|
      f.html { redirect_to qa_list_admin_ambassadors_path }
      f.js
    end
  end
  
  def unapply_qa
    @qa = AmbassadorQa.find params[:id]
    @qa.update(applied: false)
    respond_to do |f|
      f.html { redirect_to qa_list_admin_ambassadors_path }
      f.js
    end
  end

  def apply
    @ambassador = Ambassador.find params[:id]
    @ambassador.update(applied: true)
    respond_to do |f|
      f.html { redirect_to admin_ambassadors_path }
      f.js
    end
  end

  def destroy_qa
    @qa = AmbassadorQa.find params[:id]
    @qa.destroy
    redirect_to qa_list_admin_ambassadors_path
  end

  def destroy
    @a = Ambassador.find params[:id]
    @a.destroy
    redirect_to admin_ambassadors_path
  end
  
  
  

  private
  def ambassador_qa_params
    params.require(:ambassador_qa).permit(:name, :description, questions_attributes: [ :id, :title ])
  end

end
