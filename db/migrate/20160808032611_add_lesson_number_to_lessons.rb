class AddLessonNumberToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :lesson_number, :integer
  end
end
