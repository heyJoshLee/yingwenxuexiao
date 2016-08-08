class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :choices

  has_many :user_questions
  has_many :users, through: :user_questions

  before_create :generate_random_slug
  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end