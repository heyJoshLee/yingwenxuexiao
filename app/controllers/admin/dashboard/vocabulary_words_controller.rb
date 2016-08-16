class Admin::Dashboard::VocabularyWordsController < AdminController

  before_action :set_vocabulary_word, only: [:show, :update, :edit]

  
  def index
    add_breadcrumb "Vocabulary Words", admin_dashboard_vocabulary_words_path
    @vocabulary_words = VocabularyWord.all.order("created_at DESC")
  end

  def new
    add_breadcrumb "Vocabulary Words", admin_dashboard_vocabulary_words_path
    add_breadcrumb "New", new_admin_dashboard_vocabulary_word_path
    @word = VocabularyWord.new
  end

  def show
    add_breadcrumb "Vocabulary Words", admin_dashboard_vocabulary_words_path
    add_breadcrumb "New", new_admin_dashboard_vocabulary_word_path
    add_breadcrumb @vocabulary_word.main
  end

  def create
    @word = VocabularyWord.new(word_params)
    if @word.save
      flash[:success] = "Word was saved"
      redirect_to new_admin_dashboard_vocabulary_word_path
    else
      flash.now[:danger] = "There was a problem and the word was not saved"
      render :new
    end
  end

  def edit
  end

  private

  def set_vocabulary_word
    @vocabulary_word = VocabularyWord.find_by(slug: params[:id])
  end

  def word_params
    params.require(:vocabulary_word).permit!
  end

end