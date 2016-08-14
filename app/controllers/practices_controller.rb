class PracticesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Practice", practice_path
    @word = current_user.user_vocabulary_words.sample
    @choices = @word.choices(:definition)
  end

end