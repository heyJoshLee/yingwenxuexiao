class CreateLesson < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :script_english, :script_chinese
      t.string :video_url
      t.string :notes_url
      t.text :description
      t.integer :course_id
      t.timestamps
    end
  end
end
