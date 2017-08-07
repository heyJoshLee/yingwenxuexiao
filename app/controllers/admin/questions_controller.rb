class Admin::QuestionsController < AdminController

  before_action :set_course, only: [:create, :destroy, :edit, :update]
  before_action :set_lesson, only: [:create, :destroy, :edit, :update]
  before_action :set_quiz, only: [:create, :destroy, :update]
  before_action :set_question, only: [:destroy, :update]


  def create
    @question = @quiz.questions.build(question_params)
    if @question.save
      flash[:success] = "question was saved"
      # redirect_to edit_admin_course_lesson_quiz_path(@course, @lesson, @quiz)
    else
      flash.now[:danger] = "There was a problem and the question was not saved"
      # render :new
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      format.js do
        @question.update(question_params)
      end
    end
  end

  def destroy
    @question.destroy
    UserQuestion.destroy_all(question_id: @question.id)
    Choice.destroy_all(question_id: @question.id)
    # flash[:success] = "Question was deleted."
    # redirect_to edit_admin_course_lesson_quiz_path(@course, @lesson, @quiz)
    respond_to do |format|
      format.js 
    end
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:lesson_id])
  end

  def set_quiz
    @quiz = Quiz.find_by(slug: params[:quiz_id])
  end

  def set_question
    @question = Question.find_by(slug: params[:id])
  end

  def question_params
    params.require(:question).permit!
  end

end