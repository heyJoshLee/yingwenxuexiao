class LessonsController < ApplicationController
  
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = "lesson was saved"
      redirect_to lesson_path(@lesson)
    else
      flash.now[:danger] = "There was a problem and the lesson was not saved"
      render :new
    end
  end

  def edit
    @lesson = Lesson.find_by(slug: params[:id])
  end

  private

  def lesson_params
    params.require(:lesson).permit()
  end

end