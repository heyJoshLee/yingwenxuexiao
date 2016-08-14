class VocabularyWord < ActiveRecord::Base

  has_many :user_vocabulary_words
  has_many :users, through: :user_vocabulary_words


  before_create :generate_random_slug

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end