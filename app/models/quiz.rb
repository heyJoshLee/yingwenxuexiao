class Quiz < ActiveRecord::Base
  before_create :generate_random_slug

  belongs_to :lesson
  has_many :questions

  has_many :user_questions
  has_many :users, through: :user_questions

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  def total_points_possible
    points = 0
    questions.each do |question|
      points += question.value
    end

    points
  end
end