class CourseUser < ActiveRecord::Base
  validates_uniqueness_of :user_id, scope: :course_id

  belongs_to :user
  belongs_to :course
end