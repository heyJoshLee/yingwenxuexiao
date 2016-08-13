class Admin::Dashboard::VocabularyWordsController < AdminController

  before_action :set_word, only: [:show, :update, :edit]
  
  def new
    @word = VocabularyWord.new
  end

  def create
    @word = VocabularyWord.new(word_params)
    if @word.save
      flash[:success] = "word was saved"
      redirect_to word_path(@word)
    else
      flash.now[:danger] = "There was a problem and the word was not saved"
      render :new
    end
  end

  def edit
  end

  private

  def set_word
    @word = VocabularyWord.find_by(slug: params[:id])
  end

  def word_params
    params.require(:word).permit!
  end

end