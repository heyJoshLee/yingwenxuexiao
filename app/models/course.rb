class Course < ActiveRecord::Base
  has_many :lessons
  mount_uploader :main_image_url, CourseMainImageUploader

  include Sluggable
  sluggable_column :name

  validates_presence_of :name
  validates_presence_of :main_image_url
  validates_presence_of :description
end

