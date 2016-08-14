class UserVocabularyWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :vocabulary_word

  validates_uniqueness_of :user, scope: :vocabulary_word

  
  def choices(input)
    type = input
    type = :main if input == :english || input == :spelling
    choices = [vocabulary_word[type]]
    input == :spelling ? generate_spellings(choices) :  generate_choices(type, choices)
  end

  private

  def generate_choices(type, choices)
    counter = 0
    while choices.length < 4
      counter += 1
      new_choice = VocabularyWord.order("RANDOM()").first[type]
      choices << new_choice unless choices.include?(new_choice)
      choices << choices.sample if counter >= 10
    end
    choices.shuffle
  end

  def generate_spellings(choices)
    incorrect_choices = vocabulary_word.main.split("").permutation.to_a
    counter = 0
    while choices.length < 4
      counter += 1
      new_choice = incorrect_choices.sample.join("")
      choices << new_choice unless choices.include?(new_choice)
      choices << choices.sample if counter >= 10
    end
    choices.shuffle
  end


end