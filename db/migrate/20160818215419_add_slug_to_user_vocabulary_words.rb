class AddSlugToUserVocabularyWords < ActiveRecord::Migration
  def change
    add_column :user_vocabulary_words, :slug, :string
  end
end
 