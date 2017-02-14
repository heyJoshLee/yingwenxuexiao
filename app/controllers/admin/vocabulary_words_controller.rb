class Admin::VocabularyWordsController < AdminController

  before_action :set_vocabulary_word, except: [:get_related_words]

  def update
    respond_to do |format|
      format.js do
        @vocabulary_word.update(vocabulary_word_params)
        @lesson = Lesson.find(@vocabulary_word.vocabulary_wordable)
      end
    end
  end

  def destroy
      respond_to do |format|
        format.js do
          @slug = @vocabulary_word.slug
          @vocabulary_word.destroy
        end
      end
  end


  def vocabulary_word_params
    params.require(:vocabulary_word).permit!
  end

  private

  def set_vocabulary_word
    @vocabulary_word = VocabularyWord.find_by(slug: params["id"])
  end

end