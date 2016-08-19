class LessonsController < ApplicationController

  before_action :set_lesson, only: [:show, :update, :edit]
  before_action :set_course, only: [:show, :update, :edit, :complete]

  before_action :set_breadcrumbs, only: [:show]

  before_action :require_paid_membership
  
  def complete
    @lesson = Lesson.find_by(slug: params[:lesson_id])
    current_user.complete_lesson(@lesson)
    @lesson = current_user.next_lesson_in_course(@lesson.course)
    @comment = Comment.new
    respond_to do |format| 
      format.js
    end

    # redirect_to course_lesson_path(@course, @next_lesson)
  end

  def show
    @comment = Comment.new
  end

  private

  def set_breadcrumbs
    add_breadcrumb "Courses", courses_path
    add_breadcrumb @course.name, course_path(@course)
      
  end

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

end