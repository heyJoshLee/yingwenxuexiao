class VocabularyWord < ActiveRecord::Base
  has_many :user_vocabulary_words
  has_many :users, through: :user_vocabulary_words
  
  has_many :lesson_vocabulary_words
  has_many :lessons, through: :lesson_vocabulary_words

  validates_presence_of(:main)
  validates_presence_of(:chinese)
  validates_presence_of(:part_of_speech)
  validates_presence_of(:ipa)
  validates_presence_of(:sentence)
  validates_presence_of(:definition)

  before_create :generate_random_slug

  def generate_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

  def to_param
    self.slug
  end

  def self.find_related_words(search_string=false)
   return [] if search_string == false || search_string == ""
   where("main LIKE ?", "%" + search_string + "%").all
  end

  def self.mass_import(file, course)

    spreadsheet = open_spreadsheet(file)

    header = spreadsheet.row(1)

    previous_vocabulary_wordable_id_real = -1
    previous_vocabulary_wordable_id_expected = -1
    
    (2..spreadsheet.last_row).each do |i|
      row = [header, spreadsheet.row(i)].transpose
      vocabulary_word = VocabularyWord.new
      vocabulary_word.attributes = row.to_h
      
      # if no lesson, then create it in the course
      lesson = Lesson.where(id: vocabulary_word.vocabulary_wordable_id).first
      if lesson.nil?
        # if this word has the same lesson id as the last one, don't create a new lesson,
        # instead reference last one
        if vocabulary_word.vocabulary_wordable_id != previous_vocabulary_wordable_id_expected
          new_lesson = course.lessons.build(name: "CREATED FROM IMPORT", description: "This lesson was created from a mass import of vocabulary words.")
          new_lesson.lesson_number = course.lessons.count + 1
          new_lesson.save
          previous_vocabulary_wordable_id_expected = vocabulary_word.vocabulary_wordable_id
          vocabulary_word.vocabulary_wordable_id = new_lesson.id
        else
          # If lesson was just created in last iteration, then add this word to that new lesson
          previous_vocabulary_wordable_id_expected = vocabulary_word.vocabulary_wordable_id
          vocabulary_word.vocabulary_wordable_id = previous_vocabulary_wordable_id_real
        end
      end

      previous_vocabulary_wordable_id = vocabulary_word.vocabulary_wordable_id
      vocabulary_word.vocabulary_wordable_type = "Lesson"
      vocabulary_word.save
      previous_vocabulary_wordable_id_real = vocabulary_word.vocabulary_wordable_id
    end
    
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end


end