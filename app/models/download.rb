class Download < ActiveRecord::Base

  has_many :download_links, -> {order("created_at DESC")}

  before_create :generate_random_slug
  mount_uploader :main_image_url, DownloadMainImageUploader

  validates_presence_of :main_image_url
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :file_download_url

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end