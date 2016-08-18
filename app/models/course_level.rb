class CourseLevel < ActiveRecord::Base

  has_many :course_course_levels
  has_many :courses, through: :course_course_levels

  include Sluggable
  sluggable_column :name

  def to_param
    self.slug
  end

end