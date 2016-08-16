class Article < ActiveRecord::Base
  include Bootsy::Container

  include Sluggable

  sluggable_column :title
  mount_uploader :main_image_url, ArticleMainImageUploader

  has_many :article_article_topics
  has_many :article_topics, through: :article_article_topics

  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :comments, -> {order("created_at DESC")}, as: :commentable

  def preview_text
    "some text"
  end

end