class CreateVocabularyWords < ActiveRecord::Migration
  def change
    create_table :vocabulary_words do |t|
      t.string :main, :chinese, :part_of_speech, :ipa, :slug
      t.text :example_sentences, array:true, default: []
      t.timestamps
    end
  end
end
