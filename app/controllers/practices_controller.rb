class PracticesController < ApplicationController
  add_breadcrumb "Home", :root_path

  before_action :require_paid_membership, except: [:index]
  
  def index
    add_breadcrumb "Practice", practice_path
    @word = current_user.user_vocabulary_words.sample
    @choices = @word.choices(:definition)
  end

  def start
    session[:study_types] ||= study_types_array
    
    @study_type_attempted = session[:study_types].sample.to_sym

    @word = current_user.user_vocabulary_words.sample

    @choices = @word.choices(@study_type_attempted)

    question_type = :main if @study_type_attempted == :english_to_chinese || @study_type_attempted == :spoken
    question_type = :chinese if @study_type_attempted == :chinese_to_english
    question_type = :definition if @study_type_attempted == :definition
    @question = @word.vocabulary_word[question_type]

    respond_to { |format| format.js }
  end

  def attempt
    session[:study_types] ||= study_types_array

    @study_type_attempted = session[:study_types].sample.to_sym

    answer = params[:answer]


    vocabulary_word = current_user.user_vocabulary_words.find(params[:vocabulary_word_id]).vocabulary_word

    @correct = current_user.practice(@study_type_attempted, vocabulary_word, answer)

    @word = current_user.user_vocabulary_words.sample



    question_type = :main if @study_type_attempted == :english_to_chinese || @study_type_attempted == :spoken
    question_type = :chinese if @study_type_attempted == :chinese_to_english
    question_type = :definition if @study_type_attempted == :definition
    @question = @word.vocabulary_word[question_type]




    @choices = @word.choices(@study_type_attempted)

    @user = current_user

    respond_to do |format|
        format.js
      end
  end

  def change_options
    session[:study_types] = []
    session[:study_types] << :english_to_chinese if params[:study_type][:english_to_chinese] == "1"
    session[:study_types] << :chinese_to_english if params[:study_type][:chinese_to_english] == "1"
    session[:study_types] << :spoken if params[:study_type][:spoken] == "1"
    session[:study_types] << :definition if params[:study_type][:definition] == "1"
  end

  private

  def study_types_array
    [:chinese_to_english, :english_to_chinese, :definition, :spoken]
  end

end