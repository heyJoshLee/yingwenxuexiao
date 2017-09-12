class AddAudioCourseToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :audio_source, :string
  end
end
