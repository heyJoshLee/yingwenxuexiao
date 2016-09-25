class Admin::CoursesController < AdminController
  before_action :set_course, only: [:show, :update, :edit]

  add_breadcrumb "Courses", :admin_courses_path
  
  def new
    @course = Course.new
  end

  def index
    @courses = Course.all
  end

  def show
    add_breadcrumb @course.name, admin_course_path(@course)
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

  def update
    if @course.update(course_params)
      flash[:success] = "Course was saved"
      redirect_to admin_course_path(@course)
    else
      flash[:success] = "There was an error and the changes were not saved"
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:id])
  end

  def course_params
    params.require(:course).permit!
  end

end