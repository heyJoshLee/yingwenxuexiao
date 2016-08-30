class UserVocabularyWordsSetAttemptedDefaultTo1 < ActiveRecord::Migration
  def change
    change_column_default :user_vocabulary_words, :attempted, 1

  end
end
