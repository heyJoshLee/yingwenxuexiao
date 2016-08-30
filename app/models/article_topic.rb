class ArticleTopic < ActiveRecord::Base

  has_many :article_article_topics
  has_many :articles, through: :article_article_topics

  validates_uniqueness_of :name, case_sensitive: false

  include Sluggable
  sluggable_column :name

  def to_param
    self.slug
  end

end