class UserQuiz < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz

  def questions
    user.answered_questions.where(quiz_id: id)
  end
end