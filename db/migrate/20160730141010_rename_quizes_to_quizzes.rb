class RenameQuizesToQuizzes < ActiveRecord::Migration
  def change
    rename_table :quizes, :quizzes
    rename_table :user_quizes, :user_quizzes
  end
end
