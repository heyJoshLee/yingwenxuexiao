class UserVocabularyWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :vocabulary_word

  validates_uniqueness_of :user, scope: :vocabulary_word


end