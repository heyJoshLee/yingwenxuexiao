class CreateCourseCourseLevels < ActiveRecord::Migration
  def change
    create_table :course_course_levels do |t|
      t.timestamps
      t.integer :course_id, :course_level_id
    end
  end
end
