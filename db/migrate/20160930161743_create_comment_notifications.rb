class CreateCommentNotifications < ActiveRecord::Migration
  def change
    create_table :comment_notifications do |t|
      t.integer :comment_id, :user_id
      t.boolean :read, default: false
      t.string :message
      t.string :slug
    end
  end
end
