require "spec_helper"

describe VocabularyWord do
  it { should validate_presence_of(:main) }
  it { should validate_presence_of(:chinese) }
  it { should validate_presence_of(:part_of_speech) }
  it { should validate_presence_of(:ipa) }
  it { should validate_presence_of(:definition) }
  it { should validate_presence_of(:sentence) }
  it { should have_many(:lessons).through(:lesson_vocabulary_words)}
end