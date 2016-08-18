class Lesson < ActiveRecord::Base
  belongs_to :course
  
  has_many :grades
  has_many :lessons, through: :grades

  has_many :lesson_users
  has_many :users, through: :lesson_users

  before_create :generate_random_slug

  has_one :quiz

  validates_presence_of :lesson_number
  validates_numericality_of :lesson_number, {only_integer: true}

  has_many :comments, -> {order("created_at DESC")}, as: :commentable
  has_many :vocabulary_words, -> {order("created_at DESC")}, as: :vocabulary_wordable



  def has_quiz?
    quiz
  end

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end


end