class Article < ActiveRecord::Base
  include Bootsy::Container

  include Sluggable

  sluggable_column :title
  mount_uploader :main_image_url, ArticleMainImageUploader

  has_many :article_article_topics
  has_many :article_topics, through: :article_article_topics

  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :comments, -> {order("created_at DESC")}, as: :commentable
  has_many :vocabulary_words, -> {order("created_at DESC")}, as: :vocabulary_wordable


  validates_presence_of :title
  # validates_presence_of :main_image_url
  validates_presence_of :author_id
  # validates_presence_of :category_id
  validates_presence_of :body


  def preview_text
    "some text"
  end

end