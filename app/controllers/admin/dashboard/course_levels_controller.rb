class Admin::Dashboard::CourseLevelsController < AdminController

  before_action :set_course_level, only: [:show, :update, :edit, :destroy]

  def index
    @course_levels = CourseLevel.all
    @course_level = CourseLevel.new
  end
  
  def new
    @course_level = CourseLevel.new
  end

  def create
    @course_level = CourseLevel.new(course_level_params)
    respond_to do |format|
      format.html do
        if @course_level.save
          flash[:success] = "Course was saved"
          redirect_to admin_dashboard_course_levels_path
        else
          flash.now[:danger] = "There was a problem and the course_level was not saved"
          render :new
        end
      end

      format.js do
        @course_levels = CourseLevel.all
        if @course_level.save
          render view: "create"
        else
          render "error"
        end
      end
    end
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

  def destroy
    respond_to do |format|
      format.js do
        @course_level.course_course_levels.destroy_all if @course_level.course_course_levels.count > 0
        @course_level.destroy
        @course_levels = CourseLevel.all
      end

      format.html do
        flash[:success] = "Course level deleted." 
        redirect_to admin_dashboard_course_levels
      end
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