class CreateCourse < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :main_image_url
      t.boolean :premium_course, default: true

    end
  end
end
