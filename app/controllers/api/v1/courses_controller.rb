class Api::V1::CoursesController < ApplicationController
  def index
    render json: Course.all
  end
end