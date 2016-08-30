class AddSlugToCourseLevels < ActiveRecord::Migration
  def change
    add_column :course_levels, :slug, :string
  end
end
