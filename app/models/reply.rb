class Reply < ActiveRecord::Base
  belongs_to :commnet
  belongs_to :author, foreign_key: "user_id", class_name: "User"

  validates :body, presence: true, length: {minimum: 1, maximum: 500}

end