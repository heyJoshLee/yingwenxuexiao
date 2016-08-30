class Admin::ChoicesController < AdminController

  def create

    @choice = Choice.new(choice_params)

    @course = Course.find_by(slug: params[:course_id])
    @lesson = Lesson.find_by(slug: params[:lesson_id])
    @quiz = Quiz.find_by(slug: params[:quiz_id])
    @question = Question.find_by(slug: params[:question_id])

    @choice.question_id = @question.id

    if @choice.save
      flash[:success] = "Choice was saved"
      redirect_to edit_admin_course_lesson_quiz_path(@course, @lesson, @quiz)
    else
      flash.now[:danger] = "There was a problem and the choice was not saved"
      render "quizes/show"
    end
  end

  def destroy
    @course = Course.find_by(slug: params[:course_id])
    @lesson = Lesson.find_by(slug: params[:lesson_id])
    @quiz = Quiz.find_by(slug: params[:quiz_id])
    @choice = Choice.find(params[:id])
    @choice.destroy
    flash[:success] = "Choice was deleted"
    redirect_to edit_admin_course_lesson_quiz_path(@course, @lesson, @quiz)
  end

  private

  def choice_params
    params.require(:choice).permit!
  end

end