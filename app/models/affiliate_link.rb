class AffiliateLink < ActiveRecord::Base

  belongs_to :affiliate
  has_many :users

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end