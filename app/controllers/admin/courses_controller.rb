class Admin::CoursesController < AdminController
  before_action :set_course, only: [:show, :update, :edit, :rearrange, :import_quizzes, :destroy]

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

  def destroy
    @course.lessons.each do |lesson|
      if lesson.has_quiz?
        lesson.quiz.questions.each do |question|
          question.choices.destroy_all
        end
        lesson.quiz.questions.destroy_all
        lesson.quiz.destroy
      end
      lesson.comments.destroy_all
    end
    @course.lessons.destroy_all
    @course.destroy
    flash["success"] = "Course deleted."
    redirect_to admin_courses_path
  end

  def post_rearrange
    params[:lesson].each_with_index do |id, index|
      Lesson.find(id.to_i).update_attributes!(lesson_number: index + 1)
    end
    respond_to do |format|
      format.js { render :nothing => true }
    end
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

  def import_quizzes
    Quiz.mass_import(params[:file], nil, @course)
    flash[:success] = "Quizzes imported."
    redirect_to edit_admin_course_path(@course)
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:id])
  end

  def course_params
    params.require(:course).permit!
  end

end