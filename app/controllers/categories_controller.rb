class CategoriesController < ApplicationController

  before_action :set_category, only: [:show]

  private

  def set_category
    @category = Category.find_by(slug: params[:id])
  end
end