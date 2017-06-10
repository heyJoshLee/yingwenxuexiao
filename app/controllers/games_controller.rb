class GamesController < ApplicationController

  def index
    flash[:danger] = "Games are coming soon. Please check back later."
    redirect_to courses_path
  end

end