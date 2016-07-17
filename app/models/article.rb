class Article < ActiveRecord::Base
  include Bootsy::Container

  include Sluggable

  sluggable_column :title
  mount_uploader :main_image_url, ArticleMainImageUploader

  has_many :article_categories
  has_many :categories, through: :article_categories 
  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :comments, -> {order("created_at DESC")}



  def preview_text
    "some text"
  end

end