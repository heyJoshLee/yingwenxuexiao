class AddSlugToArticleTop < ActiveRecord::Migration
  def change
    add_column :article_topics, :slug, :string
  end
end
