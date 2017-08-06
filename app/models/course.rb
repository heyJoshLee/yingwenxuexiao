class Course < ActiveRecord::Base
  after_create :create_unit


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


  has_many :units, -> {order("position ASC")}
  has_many :lessons, -> {order("lesson_number ASC")}



  def to_param
    self.slug
  end

  def published_lessons
    lessons.where(published: true)
  end

  def self.free_published_courses
    where(published: true, premium_course: false)
  end

  def self.premium_published_courses
    where(published: true, premium_course: true)
  end

  def destroy_and_destroy_all_children
   lessons.each do |lesson|
      if lesson.has_quiz?
        lesson.quiz.questions.each do |question|
          question.choices.destroy_all
        end
        lesson.quiz.questions.destroy_all
        lesson.quiz.destroy
      end
      lesson.comments.destroy_all
    end
   lessons.destroy_all
   self.destroy
  end

  def create_unit
    Unit.create(name: "Generated First Unit", position: 1, course_id: self.id)
  end


end

