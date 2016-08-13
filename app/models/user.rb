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

  has_many :user_quizzes
  has_many :quizzes, through: :user_quizzes

  has_many :user_questions
  has_many :questions, through: :user_questions

  has_many :lesson_users
  has_many :lessons, through: :lesson_users


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

  def taken_quiz?(quiz)
    quizzes.where(id: quiz.id).any?
  end

  def answer_points(question)
    return 0 if !answered_correctly?(question) || !answered_question?(question)
    question.value
  end

  def answered_correctly?(question)
    answer = user_questions.find_by(question_id: question.id)
    return false unless answered_question?(question)
    answer.correct?
  end

  def selected_choice?(choice)
    choices = user_questions.map(&:choice_id)
    choices.include?(choice.id)
  end

  def quiz_score(quiz)
    return 0 unless taken_quiz?(quiz)
    total = 0
    quiz.questions.each do |question|
      total += answer_points(question)
    end
     (total.to_f / quiz.total_points_possible.to_f).round(2)
  end

  def attempt_quiz(quiz, questions_and_answers_array)
    UserQuiz.create(user_id: self.id, quiz_id: quiz.id) unless taken_quiz?(quiz)

    questions_and_answers_array.each do |qa_pair|
      answer_question(qa_pair[0], qa_pair[1])
    end
  end

  def attempted_quizzes
    user_quizzes
  end

  def answered_question?(question)
    user_questions.find_by(question_id: question.id)
  end

  def answered_questions
    user_questions
  end

  def answer_question(question, choice)
    if answered_question?(question)
      change_answer(question, choice)
    else
      UserQuestion.create(question_id: question.id, choice_id: choice.id, user_id: self.id)
    end
  end

  def complete_lesson(lesson_to_test)
    lesson = lessons.find_by(id: lesson_to_test.id)
    if lesson
      lesson_users.find_by(lesson_id: lesson_to_test.id).update_column(:completed, true)
    else
      LessonUser.create(lesson_id: lesson_to_test.id, user_id: id)
    end 
  end

  def completed_lesson?(lesson)
    lessons.find_by(id: lesson.id)
  end

  def next_lesson_in_course(course)
    if course.lessons.all? { |lesson| completed_lesson?(lesson)}
      return course.lessons.last
    end

    course.lessons.each do |lesson|
      return lesson unless completed_lesson?(lesson)
    end
    course.lessons.first
  end

  def add_points(points_to_add)
    new_points = points + points_to_add
    update_column(:points, new_points)
    advance_level_if_enough_points
  end

  private

  def advance_level_if_enough_points
    next_level =  Level.find_by(number: level + 1)
    update_column(:level, next_level.number) if points >= next_level.points
  end

  def change_answer(question, choice)
    user_question = user_questions.find_by(question_id: question.id)
    user_question.update_column(:choice_id, choice.id)
  end

end

