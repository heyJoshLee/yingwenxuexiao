class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :course_id
      t.string :slug, :name
      t.timestamps
    end
  end
end
