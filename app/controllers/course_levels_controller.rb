class CourseLevelsController < ApplicationController

  before_action :set_course_level, only: [:show]
  
  private

  def set_course_level
    @course_level = CourseLevel.find_by(slug: params[:id])
  end

end