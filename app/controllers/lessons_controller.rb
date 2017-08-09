class LessonsController < ApplicationController

  before_action :set_lesson, only: [:show, :update, :edit]
  before_action :set_course, only: [:show, :update, :edit, :complete]

  before_action :set_breadcrumbs, only: [:show]

  before_action :check_user_membership_and_course_paid_or_free
  before_action :check_enrollment_status
  
  def complete
    @lesson = Lesson.find_by(slug: params[:lesson_id])
    current_user.complete_lesson(@lesson)
    @lesson = current_user.next_lesson_in_course(@lesson.course)
    @comment = Comment.new

    redirect_to course_lesson_path(@course, current_user.next_lesson_in_course(@course))
  end

  def show
    respond_to do |format|
      format.html do
        @comment = Comment.new
      end
      format.pdf do
        is_admin = params["admin"] == "true" ? true : false
        pdf = LessonNotesPdf.new(@lesson, is_admin)
        send_data pdf.render, filename: "#{@course.name}: #{@lesson.lesson_number} - #{@lesson.name} Yingwenxuexiao.com",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end


  private

  def check_user_membership_and_course_paid_or_free
    if !logged_in?
      redirect_to sign_in_path
    elsif !current_user.is_paid_member? && !current_user.is_admin?
      redirect_to upgrade_path if @course.premium_course?
    end      
  end

  def check_enrollment_status
    redirect_to course_path(@course) unless current_user.is_enrolled_in?(@course)
  end

  def set_breadcrumbs
    add_breadcrumb "Courses", courses_path
    add_breadcrumb @course.name, course_path(@course)
  end

  def set_lesson
    @lesson = Lesson.find_by(slug: params[:id])
  end

      # @video = VideoDecorator.decorate(Video.find(params[:id]))

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

end