class EbooksController < ApplicationController
  before_action :set_ebook, only: [:show]
  before_filter :require_user, only: [:show]

  def index
    @ebooks = Ebook.all
  end

  private

  def set_ebook
    @ebook = Ebook.find_by(slug: params[:id])
  end


end