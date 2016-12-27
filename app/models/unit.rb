class Unit < ActiveRecord::Base
  before_create :generate_random_slug

  has_many :lessons, -> {order("lesson_number ASC")}

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end