class Course < ActiveRecord::Base
  has_many :lessons, -> {order("lesson_number ASC")}

  mount_uploader :main_image_url, CourseMainImageUploader

  include Sluggable
  sluggable_column :name

  validates_presence_of :name
  # validates_presence_of :main_image_url
  validates_presence_of :description

  has_many :course_user
  has_many :users, through: :course_users

  has_many :course_course_levels
  has_many :course_levels, through: :course_course_levels

  def to_param
    self.slug
  end

end

