class CoursesController < ApplicationController

  before_action :set_course, only: [:enroll, :show]
  before_action :check_user_membership_and_course_paid_or_free, only: [:enroll, :show]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Courses"


  def index
    @free_courses = Course.free_published_courses
    @premium_courses = Course.premium_published_courses
  end
  
  def show
  end

  def enroll
    current_user.enroll_in(@course)
    redirect_to course_path(@course)
  end

  private

  def set_course
    if !logged_in?
      redirect_to sign_in_path
    else
      @course = Course.find_by(slug: params[:id])
      redirect_to courses_path unless @course.published? || current_user.is_admin?
    end
  end

  def course_params
    params.require(:course).permit()
  end

  def check_user_membership_and_course_paid_or_free
    if !logged_in?
      redirect_to sign_in_path
    elsif !current_user.is_paid_member? && !current_user.is_admin?
      redirect_to upgrade_path if @course.premium_course?
    end      
  end
end