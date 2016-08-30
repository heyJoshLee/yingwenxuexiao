class CreateArticleArticleTopics < ActiveRecord::Migration
  def change
    create_table :article_article_topics do |t|
      t.integer :article_id, :article_topic_id
      t.timestamps
    end
  end
end
