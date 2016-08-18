class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :replies

  has_many :replies, -> {order("created_at DESC")}

  validates :body, presence: true, length: {minimum: 1, maximum: 500}

  before_create :generate_random_slug


  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end


end