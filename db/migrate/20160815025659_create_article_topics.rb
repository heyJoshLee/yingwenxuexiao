class CreateArticleTopics < ActiveRecord::Migration
  def change
    create_table :article_topics do |t|
      t.string :name
      t.timestamps
    end
  end
end
