class UserVocabularyWord < ActiveRecord::Base
  belongs_to :user
  belongs_to :vocabulary_word

  validates_uniqueness_of :user, scope: :vocabulary_word

  def choices(study_type)
    # input ex: :english_to_chinese, "chinese_to_english, :spoken, :definition
    type = format_choice_input(study_type)
    choices = [vocabulary_word[type]]
    type == :spelling ? generate_spellings(choices) :  generate_choices(type, choices)
  end


  def set_review_time(answered_correctly, method)
    add_time = 0
    if answered_correctly
      attempted = "#{method.to_s}_attempted".to_sym
      correct = "#{method.to_s}_correct".to_sym
      attempted_amount = self[attempted] || 0
      correct_amount = self[correct] || 0

        add_time  = if attempted_amount <= 1
                    1.minute
                  elsif attempted_amount <= 3
                    10.minute
                  elsif attempted_amount <= 5
                    1.day
                  elsif attempted_amount <= 7
                    3.day
                  elsif attempted_amount <= 12
                    5.day
                  elsif attempted_amount < 13
                      10.days
                  end
      update_column(:review_time, DateTime.parse( (Time.now + add_time).to_s ))

    end #answered correctly?
      update_column(:review_time, DateTime.parse( (Time.now + 1.minute).to_s ))

  end

  private

  def format_choice_input(input)
    if input == :english_to_chinese
       return :chinese
    elsif input == :chinese_to_english
      return :main
    elsif input == :definition
      return :definition
    elsif input == :spelling
      return :main
    else 
      return :main
    end 
  end


  def generate_choices(type, choices)
    counter = 0
    while choices.length < 4
      new_choice = VocabularyWord.all.sample[type]
      choices << new_choice unless choices.include?(new_choice) || new_choice.nil?
      counter += 1
      choices << choices.sample if counter >= 20
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