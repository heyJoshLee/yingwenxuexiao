class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :user_id, :lesson_id, :points
      t.boolean :completed, default: true
    end
  end
end
