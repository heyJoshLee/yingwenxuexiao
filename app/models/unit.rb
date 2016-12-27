class Unit < ActiveRecord::Base
  before_create :generate_random_slug
  belongs_to :course

  has_many :lessons, -> {order("lesson_number ASC")}

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def published_lessons
    lessons.where(published: true)
  end

  def to_param
    self.slug
  end

  def has_lessons?
    lessons.length > 0
  end

  def has_published_lessons?
    published_lessons.length > 0
  end

  private


end