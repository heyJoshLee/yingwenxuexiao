class CreateUserActions < ActiveRecord::Migration
  def change
    create_table :user_actions do |t|
      t.integer :user_id
      t.timestamps
      t.string :slug, :action_type
      t.text :body
    end
  end
end
