class AddTimestampsToUserQuestionsQuizzesUserQuizzesQuestionCoursesCourseUsers < ActiveRecord::Migration
  def change
    add_column :choices, :created_at, :datetime
    add_column :choices, :updated_at, :datetime

    add_column :course_users, :created_at, :datetime
    add_column :course_users, :updated_at, :datetime

    add_column :courses, :created_at, :datetime
    add_column :courses, :updated_at, :datetime

    add_column :questions, :created_at, :datetime
    add_column :questions, :updated_at, :datetime

    add_column :quizzes, :created_at, :datetime
    add_column :quizzes, :updated_at, :datetime

    add_column :user_questions, :created_at, :datetime
    add_column :user_questions, :updated_at, :datetime

    add_column :user_quizzes, :created_at, :datetime
    add_column :user_quizzes, :updated_at, :datetime

  end
end
