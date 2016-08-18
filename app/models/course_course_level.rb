class CourseCourseLevel < ActiveRecord::Base
  belongs_to :course
  belongs_to :course_level
end