class Download < ActiveRecord::Base

  has_many :download_links

  before_create :generate_random_slug
  mount_uploader :main_image_url, DownloadMainImageUploader


  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end