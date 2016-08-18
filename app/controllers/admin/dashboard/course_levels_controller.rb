class Admin::Dashboard::CourseLevelsController < AdminController

  before_action :set_course_level, only: [:show, :update, :edit]

  def index
    @course_levels = CourseLevel.all
    @course_level = CourseLevel.new
  end
  
  def new
    @course_level = CourseLevel.new
  end

  def create
    @course_level = CourseLevel.new(course_level_params)
    if @course_level.save
      flash[:success] = "Course was saved"
      redirect_to admin_dashboard_course_levels_path
    else
      flash.now[:danger] = "There was a problem and the course_level was not saved"
      render :new
    end
  end

  def edit
  end

  def update
    if @course_level.update(course_level_params)
      flash[:success] = "Course Level was saved"
      redirect_to admin_dashboard_course_levels_path
    else
      flash.now[:danger] = "There was a problem and the course_level was not saved"
      render :edit
    end
  end

  private

  def set_course_level
    @course_level = CourseLevel.find_by(slug: params[:id])
  end

  def course_level_params
    params.require(:course_level).permit!
  end

end