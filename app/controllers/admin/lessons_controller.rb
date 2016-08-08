class Admin::LessonsController < AdminController

  before_action :set_course, only: [:create, :new, :edit, :update, :show]
  before_action :set_lesson, only: [:show, :edit, :update]
  before_action :set_quiz, only: [:show]

  before_action :course_breadcrumb

  
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    next_lesson_number = @course.lessons.count + 1
    @lesson.lesson_number = next_lesson_number
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
    add_breadcrumb @lesson.name, admin_course_lesson_path(@course, @lesson)
  end

  private

  def course_breadcrumb
    add_breadcrumb "Courses", :admin_courses_path
    add_breadcrumb @course.name, admin_course_path(@course)
  end

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

  def set_quiz
    @quiz = Quiz.find_by(slug: params[:quiz_id])    
  end

  def lesson_params
    params.require(:lesson).permit!
  end

end