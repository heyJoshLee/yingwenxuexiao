class ChangeQuizFeaultToNotAttemped < ActiveRecord::Migration
  def change
    change_column_default :quizzes, :attempted, false
  end
end
