class VocabularyWord < ActiveRecord::Base

  has_many :user_vocabulary_words
  has_many :users, through: :user_vocabulary_words
  belongs_to :vocabulary_wordable, polymorphic: true

  validates_presence_of(:main)
  validates_presence_of(:chinese)
  validates_presence_of(:part_of_speech)
  validates_presence_of(:ipa)
  validates_presence_of(:sentence)
  validates_presence_of(:definition)

  before_create :generate_random_slug

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

end