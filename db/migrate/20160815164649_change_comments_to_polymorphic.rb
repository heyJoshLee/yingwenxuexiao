class ChangeCommentsToPolymorphic < ActiveRecord::Migration
  def change
    remove_column :comments, :article_id
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
  end
end
