class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :author, foreign_key: "user_id", class_name: "User"

  has_many :replies

  validates :body, presence: true, length: {minimum: 1, maximum: 500}

end