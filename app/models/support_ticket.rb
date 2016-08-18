class SupportTicket < ActiveRecord::Base

  before_create :generate_random_slug

  validates_presence_of(:name)
  validates_presence_of(:subject)
  validates_presence_of(:email)
  validates_presence_of(:body)

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end