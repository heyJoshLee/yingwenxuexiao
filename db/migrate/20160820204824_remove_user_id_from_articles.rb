class RemoveUserIdFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :user_id
  end
end
