class Category < ActiveRecord::Base

  has_many :articles

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :image_url

  mount_uploader :image_url, CategoryImageUploader

  include Sluggable
  sluggable_column :name

  has_many :article_categories
  has_many :articles, through: :post_categories 




end