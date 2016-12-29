class AddTimestampsToCommentNotifications < ActiveRecord::Migration
  def change
    add_column :comment_notifications, :created_at, :datetime
    add_column :comment_notifications, :updated_at, :datetime
  end

end
