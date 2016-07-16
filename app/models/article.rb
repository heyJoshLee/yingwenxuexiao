class Article < ActiveRecord::Base
  include Bootsy::Container

  include Sluggable

  sluggable_column :title
  mount_uploader :main_image_url, ArticleMainImageUploader

  has_many :article_categories
  has_many :categories, through: :article_categories 


  def preview_text
    "some text"
  end

end