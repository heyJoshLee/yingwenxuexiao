class UserVocabularyWordsController < ApplicationController

  before_action :set_user_vocabulary_word, only: [:show, :update, :edit]
  before_action :set_vocabulary_word, only: [:create]

  before_action :require_paid_membership, only: [:create, :create]
  
  def new
    @user_vocabulary_word = UserVocabularyWord.new
  end

  def show
    @user = current_user
  end

  def create
    if current_user.add_vocabulary_word(@vocabulary_word)
      @object = Lesson.find_by(slug: params[:lesson_slug])
      respond_to { |format| format.js }
    else
      respond_to do |format| 
        format.js { render "error" }
      end
    end
  end

  def update
    if @user_vocabulary_word.update(@user_vocabulary_word_params)
      flash[:success] = "user_vocabulary_word was saved"
      redirect_to user_vocabulary_word_path(@user_vocabulary_word)
    else
      flash.now[:danger] = "There was a problem and the user_vocabulary_word was not saved"
      render :edit
    end
  end

  private

  def set_user_vocabulary_word
    @user_vocabulary_word = UserVocabularyWord.find_by(slug: params[:id])
  end

  def set_vocabulary_word
    @vocabulary_word = VocabularyWord.find_by(slug: params[:vocabulary_word_id])
  end

  def user_vocabulary_word_params
    params.require(:user_vocabulary_word).permit!
  end

end