class Admin::LessonsController < AdminController

  before_action :set_course, only: [:create, :new, :edit, :update, :show, :import_vocabulary_words, :destroy, :import_quiz]
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :import_quiz]
  before_action :set_quiz, only: [:show]

  before_action :course_breadcrumb, except: [:import_vocabulary_words, :import_quiz]

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

  def destroy
    if @lesson.has_quiz?
      @lesson.quiz.questions.each do |question|
        question.choices.destroy_all
        question.destroy
      end
    end
    @lesson.comments.destroy_all
    @lesson.destroy

    flash[:success] = "Lesson destroyed."
    redirect_to admin_course_path(@course)
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

  def import_vocabulary_words
    VocabularyWord.mass_import(params[:file], @course)
    flash[:success] = "Words imported."
    redirect_to edit_admin_course_path(@course)
  end

  def import_quiz
    Quiz.mass_import(params[:file], @lesson)
    flash[:success] = "Quiz imported."
    redirect_to edit_admin_course_lesson_path(@course, @lesson)
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
    params.require(:lesson).permit(:bootsy_image_gallery_id, :name, :script_english, :script_chinese, :video_url, :notes_url, :description, :course_id, :lesson_number, :published, :instructions)
  end

end