class AffiliateLink < ActiveRecord::Base

  belongs_to :affiliate
  has_many :users
  before_create :generate_random_slug
  before_save :create_url

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  private

  def create_url
    self.url = "TaiwanEnglishSchool.com/signup/" + code if code 
  end

end