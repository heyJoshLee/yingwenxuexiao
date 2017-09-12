class AffiliatePayment < ActiveRecord::Base
  before_create :generate_random_slug
  belongs_to :affiliate_link
  belongs_to :user
  


  def to_param
    self.slug
  end


  private

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

end