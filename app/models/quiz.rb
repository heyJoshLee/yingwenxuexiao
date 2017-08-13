class Quiz < ActiveRecord::Base
  before_create :generate_random_slug

  belongs_to :lesson
  has_many :questions

  has_many :user_questions
  has_many :users, through: :user_questions

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  def total_points_possible
    points = 0
    questions.each do |question|
      points += question.value
    end
    points
  end

  def self.mass_import(file, lesson=false, course=nil)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    previous_question_id = -1
    quiz_id = false

    if lesson 
      Quiz.create(lesson_id: lesson.id) unless lesson.has_quiz?
      quiz_id = lesson.reload.quiz.id
    end

    (2..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose
      row_hash = row.to_h
      lesson = false

      if course 
        lesson = Lesson.where(id: row_hash["quiz_id"].to_i).first || Lesson.create(course_id: course.id, name: "CREATED FROM QUIZZES IMPORT", description: "CREATED FROM QUIZZES IMPORT")
        if lesson.has_quiz?
          quiz_id = lesson.quiz.id
        else
          quiz_id = Quiz.create(lesson_id: lesson.id).id
        end
      end


      if row_hash["type"].strip.downcase == "question"
      # if question create question and store id for next row that is a choice.
        previous_question_id = Question.create(quiz_id: quiz_id || Lesson.find(row_hash["quiz_id"]).quiz.id, value: row_hash["value"] || 10, body: row_hash["body"]).id
      elsif (row_hash["type"].nil? || row_hash["type"].strip.downcase == "choice") && previous_question_id != -1
      # Create choice and add it to previous question
        Choice.create(question_id: previous_question_id,
                      correct: (row_hash["correct"].to_s.strip.downcase == "true" || row_hash["correct"].to_s.strip.downcase == "yes"),
                      body: row_hash["body"])
        end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end