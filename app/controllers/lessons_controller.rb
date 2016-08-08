class LessonsController < ApplicationController

  before_action :set_lesson, only: [:show, :update, :edit, :complete]
  before_action :set_course, only: [:show, :update, :edit]
  
  def complete
     current_user.complete_lesson(@lesson)
  end


  private

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

end