class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, :main_image_url
      t.integer :author_id, :category_id
      t.text :body
      t.timestamps
    end
  end
end
