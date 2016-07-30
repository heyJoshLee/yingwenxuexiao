class LessonsController < ApplicationController

  before_action :set_lesson, only: [:show, :update, :edit]
  before_action :set_course, only: [:show, :update, :edit]
  
  # def new
  #   @lesson = Lesson.new
  # end

  # def create
  #   @lesson = Lesson.new(lesson_params)
  #   if @lesson.save
  #     flash[:success] = "lesson was saved"
  #     redirect_to lesson_path(@lesson)
  #   else
  #     flash.now[:danger] = "There was a problem and the lesson was not saved"
  #     render :new
  #   end
  # end

  def edit
  end

  # private

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

  # def lesson_params
  #   params.require(:lesson).permit!
  # end

end