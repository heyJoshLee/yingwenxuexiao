class Games::FlashCardsController < ApplicationController
  before_action :require_paid_membership 
  before_action :set_flash_cards_hash, only: [:attempt, :index, :toggle_options]

  def attempt
    question_type = session[:flash_card_study_type].to_sym
    question = UserVocabularyWord.find(params[:question_id]).vocabulary_word
    check_type = nil

    if question_type == :chinese_to_english
      check_type = :main
    elsif question_type == :english_to_chinese
      check_type = :chinese
    elsif question_type == :definition
      check_type = :definition
    end

    choice = params[:choice]
    @answered_correctly = question[check_type] == choice

      user_word = current_user.user_vocabulary_words.find_by(vocabulary_word_id: question.id)
      old_attempts = user_word.definition_attempted
      new_attempts = old_attempts + 1
      user_word.update_column(:definition_attempted, new_attempts)


    if @answered_correctly 
      # current_user.add_points(2)
      # Need to fix adding points
      old_correct = user_word.definition_correct
      new_correct = old_correct + 1
      user_word.update_column(:definition_correct, new_correct)
      old_time = user_word.review_time
      new_time = old_time + 1.day
      user_word.update_column(:review_time, new_time)
    end


    #set up new word and choice to load next question
    @word = current_user.user_vocabulary_words.sample
    @choices = @word.choices(session[:flash_card_study_type].to_sym)

    respond_to { |format| format.js }
  end

  def index
    session[:flash_card_study_type] = "english_to_chinese"
    if current_user.user_vocabulary_words.length == 0
      flash[:danger] = "你沒有任何詞彙單詞。在玩這個遊戲之前，您需要從課上獲取詞彙單詞"
      redirect_to games_path
    else
      @word = current_user.user_vocabulary_words.sample
      @choices = @word.choices(session[:flash_card_study_type].to_sym)
    end
  end

  def toggle_options
    respond_to do |format|
      format.js do
        session[:flash_card_study_type] = params[:study_type].to_sym
        puts "STUDY TYPE IS #{session[:flash_card_study_type]}"
        render :nothing => true

      end
    end
  end

  private

  def set_flash_cards_hash
    session[:flash_cards] = {} if session[:flash_cards] == nil
  end
end
