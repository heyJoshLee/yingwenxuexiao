class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :user_id, :course_id
      t.boolean :completed, :enrolled
    end
  end
end
