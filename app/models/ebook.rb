class Ebook < ActiveRecord::Base
  mount_uploader :cover_img, EbookCoverImgUploader
  mount_uploader :src, EbookSrcUploader
  before_create :generate_random_slug

  validates_presence_of :title
  validates_presence_of :cover_img
  validates_presence_of :src
  validates_presence_of :description


  def to_param
    self.slug
  end

  private

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end





end