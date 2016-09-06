class CoursesController < ApplicationController

  before_action :require_paid_membership, except: [:index]
  before_action :set_course, only: [:enroll, :show]

  add_breadcrumb "Home", :root_path
  add_breadcrumb "Courses"


  def index
    @courses = Course.published_courses
  end
  
  def new
    @course = Course.new
  end

  def show
  end

  # def create
  #   @course = Course.new(course_params)
  #   if @course.save
  #     flash[:success] = "course was saved"
  #     redirect_to course_path(@course)
  #   else
  #     flash.now[:danger] = "There was a problem and the course was not saved"
  #     render :new
  #   end
  # end

  def enroll
    current_user.enroll_in(@course)
    redirect_to course_path(@course)
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:id])
  end

  def course_params
    params.require(:course).permit()
  end

end