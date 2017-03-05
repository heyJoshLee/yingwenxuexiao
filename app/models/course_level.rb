class CourseLevel < ActiveRecord::Base

  has_many :course_course_levels
  has_many :courses, through: :course_course_levels

  validates_presence_of :name
  validates :color, length: { is: 7 }


  include Sluggable
  sluggable_column :name

  def to_param
    self.slug
  end

end