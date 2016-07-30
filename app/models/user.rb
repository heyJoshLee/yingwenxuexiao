class User < ActiveRecord::Base
  has_secure_password validations: false


  validates :email, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :password, presence: true, length: {minimum: 5, maximum: 20}

  has_many :comments
  has_many :articles

  has_many :course_users
  has_many :courses, through: :course_users

  has_many :grades
  has_many :lessons, through: :grades

  def is_editor?
    role == "editor"
  end

  def is_admin?
    role == "admin"
  end

  def enroll_in(course)
    CourseUser.create(course_id: course.id, user_id: self.id)
  end

  def is_enrolled_in?(course)
    !courses.where(id: course.id).empty?
  end

end

