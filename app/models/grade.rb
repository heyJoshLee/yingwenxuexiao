class Grade < ActiveRecord::Base
  validates_uniqueness_of :user_id, scope: :lesson_id

  belongs_to :user
  belongs_to :lesson
end