class QuizzesController < ApplicationController

  before_action :require_paid_membership

  def attempt
    @course = Course.find_by(slug: params[:course_id])
    @lesson = Lesson.find_by(slug: params[:lesson_id])
    @quiz = Quiz.find_by(slug: params[:quiz_id])

    if params[:questions]
      questions_and_answers_array = []

      params[:questions].each do |question_and_answer_pair|
        choice = Choice.find(question_and_answer_pair[1])
        questions_and_answers_array << [choice.question, choice]
      end
      
      current_user.attempt_quiz(@quiz, questions_and_answers_array)

      flash[:success] = "Successfully attempted quiz."
    else
      flash[:danger] = "You did not answer any questions"
    end
      redirect_to course_lesson_path(@course, @lesson)
  end
  
end
