class PracticesController < ApplicationController
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Practice", practice_path
  end

end