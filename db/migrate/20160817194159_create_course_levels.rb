class CreateCourseLevels < ActiveRecord::Migration
  def change
    create_table :course_levels do |t|
      t.timestamps
      t.string :name, :color
    end
  end
end
