class Admin::Dashboard::VocabularyWordsController < AdminController

  before_action :set_vocabulary_word, only: [:show, :update, :edit, :update]

  
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
    @word.vocabulary_wordable_type = params[:vocabulary_wordable_type]
    @word.vocabulary_wordable_id = params[:vocabulary_wordable_id]
    # parent_object = @word.vocabulary_wordable
    if @word.save
      flash[:success] = "Word was saved"
      lesson = Lesson.find(@word.vocabulary_wordable_id)
      redirect_to edit_admin_course_lesson_path(lesson.course, lesson)
    #   if parent_object.class.to_s == "Article"
    #     redirect_to edit_admin_article_path(parent_object)
    #   elsif parent_object.class.to_s == "Lesson"
    #     redirect_to edit_admin_course_lesson_path(parent_object.course, parent_object)
    #   else
    #     redirect_to admin_dashboard_path
    #   end
    # else
    end
  end

  def update
    if @vocabulary_word.update(word_params)
      flash[:success] = "Word has been saved."
      redirect_to edit_admin_dashboard_vocabulary_word_path(@vocabulary_word)
    else
      flash.now[:danger] = "There was an error and the word was not saved."
      render "edit"
    end
  end


  def get_related_words
    respond_to do |format|
      search_query = params[:search_query]
      @lesson = Lesson.find(params[:lesson_id])
      puts "searching for '#{search_query}'..."
      format.js do
        return_data = VocabularyWord.find_related_words(search_query)
        puts return_data
        @vocabulary_results = return_data
      end
    end
  end

  private

  def set_vocabulary_word
    @vocabulary_word = VocabularyWord.find_by(slug: params[:id])
  end

  def word_params
    params.require(:vocabulary_word).permit!
  end

end