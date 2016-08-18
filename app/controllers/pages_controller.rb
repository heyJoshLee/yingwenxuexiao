class PagesController < ApplicationController

  def index
    render layout: "no_nav"
  end


  def careers
    add_breadcrumb "Careers"
  end

  def our_method
    add_breadcrumb "Our Method"
  end
end
