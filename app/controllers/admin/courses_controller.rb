class Admin::CoursesController < AdminController
  before_action :set_course, only: [:show]
  
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "course was saved"
      redirect_to admin_course_path(@course)
    else
      flash.now[:danger] = "There was a problem and the course was not saved"
      render :new
    end
  end

  def edit
    @course = Course.find_by(slug: params[:id])
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:id])
  end

  def course_params
    params.require(:course).permit!
  end

end