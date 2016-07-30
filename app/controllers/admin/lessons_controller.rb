class Admin::LessonsController < AdminController

  before_action :set_course, only: [:create, :new, :edit, :update]
  before_action :set_lesson, only: [:show, :edit, :update]
  
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = "lesson was saved"
      redirect_to admin_course_lesson_path(@course, @lesson)
    else
      flash.now[:danger] = "There was a problem and the lesson was not saved"
      render :new
    end
  end

 def update
    if @lesson.update(lesson_params)
      flash[:success] = "Lesson saved"
      redirect_to course_lesson_path(@course, @lesson)
    else
      flash[:danger] = "There was an error and your Lesson was not saved"
      render :edit
    end
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit!
  end

end