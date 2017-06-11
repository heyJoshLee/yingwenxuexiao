class GamesController < ApplicationController

  def index
    flash[:danger] = "遊戲即將推出。請稍後再回來."
    # flash[:danger] = "Games are coming soon. Please check back later."
    redirect_to courses_path
  end

end