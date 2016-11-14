class Games::FlashCardsController < ApplicationController
  before_action :require_paid_membership 
  before_action :set_flash_cards_hash, only: [:attempt, :index, :toggle_options]

  def attempt
    # session[:flash_card_type] = :definition
    # question_type = session[:flash_card_type]
    # question = UserVocabularyWord.find(params[:question_id]).vocabulary_word
    # choice = params[:choice]
    # @answered_correctly = question[question_type] == choice

    #   user_word = current_user.user_vocabulary_words.find_by(vocabulary_word_id: question.id)
    #   old_attempts = user_word.definition_attempted
    #   new_attempts = old_attempts + 1
    #   user_word.update_column(:definition_attempted, new_attempts)


    # if @answered_correctly 
    #   current_user.add_points(2)
    #   old_correct = user_word.definition_correct
    #   new_correct = old_correct + 1
    #   user_word.update_column(:definition_correct, new_correct)
    #   old_time = user_word.review_time
    #   new_time = old_time + 1.day
    #   user_word.update_column(:review_time, new_time)
    # end


    # #set up new word and choice to load next question
    # @word = current_user.user_vocabulary_words.sample
    # @choices = @word.choices(:definition)

    # respond_to { |format| format.js }
  end

  def index
    # @word = current_user.user_vocabulary_words.sample
    # @choices = @word.choices(:definition)
  end

  def toggle_options
    option_type = params[:option_type].to_sym
    session[:flash_cards][option_type] = params[:checked]
    puts session[:flash_cards][option_type]
    respond_to { |format| format.js }
  end

  private

  def set_flash_cards_hash
    session[:flash_cards] = {} if session[:flash_cards] == nil
  end
end
