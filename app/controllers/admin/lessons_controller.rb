class Admin::LessonsController < ApplicationController

  before_action :set_course, only: [:create, :new]
  before_action :set_lesson, only: [:show, :edit]
  
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      flash[:success] = "lesson was saved"
      redirect_to admin_course_lesson_path(@course, @lesson)
    else
      flash.now[:danger] = "There was a problem and the lesson was not saved"
      render :new
    end
  end

  def show
  end

  private

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit!
  end

end