class Article < ActiveRecord::Base
  include Bootsy::Container

  include Sluggable

  default_scope { order('created_at DESC') }

  sluggable_column :title
  mount_uploader :main_image_url, ArticleMainImageUploader

  has_many :article_article_topics
  has_many :article_topics, through: :article_article_topics

  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :comments, -> {order("created_at DESC")}, as: :commentable
  has_many :vocabulary_words, -> {order("created_at DESC")}, as: :vocabulary_wordable


  validates_presence_of :title
  # validates_presence_of :main_image_url
  validates_presence_of :user_id
  # validates_presence_of :category_id
  validates_presence_of :body


  def preview_text
    stripped_text = ActionView::Base.full_sanitizer.sanitize(body).gsub(/\s+/, ' ')
    output = stripped_text[0...200]
    output += " ..." unless output == stripped_text
    output
  end

  def self.randomArticle(ids_to_exclude=false)
    article = false
    if ids_to_exclude
      article = where("published = ? AND id NOT IN (?)", true , ids_to_exclude ).order( "RANDOM()" ).first
    else
      article = where("published = ?", true ).order( "RANDOM()" ).first
    end
    article == [] ? false : article
  end

end