class AddChoiceIdToUserQuestionsAddAttemptedToUserQuizzesRemoveAttemptedFromQuizzes < ActiveRecord::Migration
  def change
    remove_column :quizzes, :attempted
    add_column :user_questions, :choice_id, :integer
  end
end
