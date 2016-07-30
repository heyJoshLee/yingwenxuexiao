class Lesson < ActiveRecord::Base
  belongs_to :course
  
  has_many :grades
  has_many :lessons, through: :grades

  before_create :generate_random_slug

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end


end