class CreateQuizes < ActiveRecord::Migration
  def change
    create_table :quizes do |t|
      t.integer :lesson_id
      t.boolean :attempted, default: true
    end
  end
end
