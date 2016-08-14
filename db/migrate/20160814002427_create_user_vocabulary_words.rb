class CreateUserVocabularyWords < ActiveRecord::Migration
  def change
    create_table :user_vocabulary_words do |t|
      t.integer :user_id, :vocabulary_word_id, :attempted, :correct
      t.datetime :review_time, default: Date.today
      t.timestamps
    end
  end
end
