class Course < ActiveRecord::Base
  has_many :lessons
  mount_uploader :main_image_url, CourseMainImageUploader

  include Sluggable
  sluggable_column :name
end