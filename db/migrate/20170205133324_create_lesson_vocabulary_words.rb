class CreateLessonVocabularyWords < ActiveRecord::Migration
  def change
    create_table :lesson_vocabulary_words do |t|
      t.timestamps
      t.integer :lesson_id, :vocabulary_word_id
    end
  end
end
