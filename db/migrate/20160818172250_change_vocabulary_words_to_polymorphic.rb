class ChangeVocabularyWordsToPolymorphic < ActiveRecord::Migration
  def change
    add_column :vocabulary_words, :vocabulary_wordable_type, :string
    add_column :vocabulary_words, :vocabulary_wordable_id, :integer
  end
end
