class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :question_id
      t.boolean :correct
      t.text :body
    end
  end
end
