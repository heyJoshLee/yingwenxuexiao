class AddSpellingToUserVocabularyWords < ActiveRecord::Migration
  def change
    add_column :user_vocabulary_words, :spelling_attempted, :integer
    add_column :user_vocabulary_words, :spelling_correct, :integer
  end
end
