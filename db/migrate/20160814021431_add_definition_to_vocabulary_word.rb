class AddDefinitionToVocabularyWord < ActiveRecord::Migration
  def change
    remove_column :vocabulary_words, :example_sentences
    add_column :vocabulary_words, :sentence, :text
    add_column :vocabulary_words, :definition, :text
  end
end
