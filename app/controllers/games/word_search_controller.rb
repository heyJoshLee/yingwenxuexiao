class Games::WordSearchController < ApplicationController

  before_action :require_paid_membership


  def index
  end


  def found_word
    current_user.add_points(2)
    respond_to do |format|
      format.json { head :ok }
    end
  end
end