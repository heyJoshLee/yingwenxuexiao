class ArticleArticleTopic < ActiveRecord::Base

  belongs_to :article
  belongs_to :article_topic


end