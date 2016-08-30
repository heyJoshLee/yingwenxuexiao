class ResetColumnsForUserVocabularyWordsToMatchAllWaysToTest < ActiveRecord::Migration
  def change
    remove_column :user_vocabulary_words, :attempted
    remove_column :user_vocabulary_words, :correct

    add_column :user_vocabulary_words, :english_to_chinese_attempted, :integer
    add_column :user_vocabulary_words, :english_to_chinese_correct, :integer


    add_column :user_vocabulary_words, :chinese_to_english_attempted, :integer
    add_column :user_vocabulary_words, :chinese_to_english_correct, :integer


    add_column :user_vocabulary_words, :definition_attempted, :integer
    add_column :user_vocabulary_words, :definition_correct, :integer


    add_column :user_vocabulary_words, :spoken_attempted, :integer
    add_column :user_vocabulary_words, :spoken_correct, :integer


  end
end
