class AddPublishedToPostsLessonsCourses < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean, default: false
    add_column :courses, :published, :boolean, default: false
    add_column :lessons, :published, :boolean, default: false
  end
end
