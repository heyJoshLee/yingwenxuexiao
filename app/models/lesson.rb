class Lesson < ActiveRecord::Base
  include Bootsy::Container
  belongs_to :course
  belongs_to :unit
  
  has_many :grades
  has_many :lessons, through: :grades

  has_many :lesson_users
  has_many :users, through: :lesson_users

  before_create :generate_random_slug
  after_create :assign_unit

  has_one :quiz

  validates_presence_of :lesson_number
  validates_numericality_of :lesson_number, {only_integer: true}

  has_many :comments, -> {order("created_at DESC")}, as: :commentable


  has_many :lesson_vocabulary_words
  has_many :vocabulary_words, through: :lesson_vocabulary_words



  def has_quiz?
    quiz.nil? ? false : true
  end

  def to_param
    self.slug
  end


  def add_vocabulary_word(word)
    lesson_vocabulary_words.build(vocabulary_word_id: word.id).save unless LessonVocabularyWord.where(lesson_id: id, vocabulary_word_id: word.id).count > 0
  end

  def remove_vocabulary_word(word)
    LessonVocabularyWord.where(vocabulary_word_id: word.id, lesson_id: id).first.destroy
  end

  private 

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def assign_unit
    # Assign to course's last unit, creates unit if no units
    unit_id = course.units.empty? ? Unit.create(name: "Unit One", position: 1, course_id: course.id).id : course.units.last.id
    update_column(:unit_id, unit_id )
  end




end