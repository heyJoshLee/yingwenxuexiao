class DownloadLink < ActiveRecord::Base

  belongs_to :download

  before_create :generate_random_slug


  def send_email
    AppMailer.send_download_link(self).deliver
  end

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end