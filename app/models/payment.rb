class Payment < ActiveRecord::Base
  before_create :generate_random_slug
  belongs_to :user
  default_scope { order('created_at DESC') }


  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end
end
