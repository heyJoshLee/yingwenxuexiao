class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
      t.integer :article_id, :category_id
      t.timestamps
    end
  end
end
