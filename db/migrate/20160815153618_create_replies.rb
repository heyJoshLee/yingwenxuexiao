class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.timestamps
      t.integer :comment_id, :user_id
      t.text :body
    end
  end
end
