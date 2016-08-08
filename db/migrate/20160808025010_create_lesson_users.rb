class CreateLessonUsers < ActiveRecord::Migration
  def change
    create_table :lesson_users do |t|
      t.integer :lesson_id, :user_id
      t.boolean :completed, default: true
      t.timestamps
    end
  end
end
