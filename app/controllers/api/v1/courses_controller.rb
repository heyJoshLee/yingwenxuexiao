class Api::V1::CoursesController < ApplicationController
  before_action :require_user_api, except: [:index]
  before_action :set_course, except: [:index]
  def index
    render json: Course.all
  end


  def show
    render json: @course.to_json(:include => :lessons)
  end


  private

  def set_course
    @course = Course.find_by(slug: params[:id])
  end
end