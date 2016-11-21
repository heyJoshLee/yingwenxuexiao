class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.timestamps
      t.integer :sender_id, :receiver_id
      t.boolean :read, default: false
      t.string :subject, default: "Message from Admin"
      t.string :slug
      t.text :body
    end
  end
end
