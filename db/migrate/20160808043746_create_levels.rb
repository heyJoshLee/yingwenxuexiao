class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :points
      t.text :message
      t.timestamps
    end
  end
end
