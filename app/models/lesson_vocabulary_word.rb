class LessonVocabularyWord < ActiveRecord::Base

  belongs_to :lesson
  belongs_to :vocabulary_word

end