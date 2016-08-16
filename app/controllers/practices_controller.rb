class PracticesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    session[:english_to_chinese] = true
    session[:chinese_to_english] = true
    session[:definition] = true
    session[:spoken] = true
    add_breadcrumb "Practice", practice_path
    @word = current_user.user_vocabulary_words.sample
    @choices = @word.choices(:definition)
    @study = :definition
  end

  def start
    @word = current_user.user_vocabulary_words.sample
    @choices = @word.choices(:definition)
    @study = :definition
    respond_to do |format|
        format.js
      end
  end

  def attempt
    study_type = :definition
    answer = params[:answer]
    vocabulary_word = current_user.user_vocabulary_words.find(params[:vocabulary_word_id]).vocabulary_word
    @correct = current_user.practice(study_type, vocabulary_word, answer)
    @word = current_user.user_vocabulary_words.sample
    @choices = @word.choices(:definition)
    @user = current_user
    respond_to do |format|
        format.js
      end
  end

end