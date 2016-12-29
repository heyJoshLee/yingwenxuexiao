class AddDefaultIntsToUserVocabularyWordAttempts < ActiveRecord::Migration
  def change
    change_column_default :user_vocabulary_words, :english_to_chinese_attempted , 0
    change_column_default :user_vocabulary_words, :english_to_chinese_correct , 0

    change_column_default :user_vocabulary_words, :chinese_to_english_attempted , 0
    change_column_default :user_vocabulary_words, :chinese_to_english_correct , 0

    change_column_default :user_vocabulary_words, :definition_attempted , 0
    change_column_default :user_vocabulary_words, :definition_correct , 0
       
    change_column_default :user_vocabulary_words, :spoken_attempted , 0
    change_column_default :user_vocabulary_words, :spoken_correct , 0
       
      
    change_column_default :user_vocabulary_words, :spelling_attempted , 0
    change_column_default :user_vocabulary_words, :spelling_correct , 0
  end
end
