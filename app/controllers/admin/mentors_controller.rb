class Admin::MentorsController < Admin::BaseController

  def index
    @mentors = Mentor.all.page(params[:page]).per(10)
  end

  def show
    @mentor = Mentor.find params[:id]
    
  end

  def apply
    @mentor = Mentor.find params[:id]
    @mentor.update(applied: true)
    respond_to do |f|
      f.html { redirect_to admin_mentors_path }
      f.js
    end
  end

  def destroy
    @mentor = Mentor.find params[:id]
    @mentor.destroy
    redirect_to admin_mentors_path
  end

end
