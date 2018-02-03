class Admin::EbooksController < AdminController
    before_action :set_ebook, only: [:edit, :update]
    before_action :index_breadcrumb, only: [:edit, :new]
  def new
    @ebook = Ebook.new
  end

  def index
    @ebooks = Ebook.all
  end

  def create
    @ebook = Ebook.new(ebook_params)
    if @ebook.save
      flash[:success] = "Ebook was created."
      redirect_to admin_ebooks_path
    else
      flash.now[:danger] = "Ebook was not saved."
      render :new
    end
  end

  def update
    if @ebook.update(ebook_params)
      flash[:success] = "Ebook updated."
      redirect_to admin_ebooks_path
    else
      flash[:danger] = "There was an error and the ebook was not saved"
      render :edit
    end
  end

  def destroy
  end

  private

  def index_breadcrumb
    add_breadcrumb "Ebooks", :admin_ebooks_path
  end


  def set_ebook
    @ebook = Ebook.find_by(params[:slug])    
  end

  def ebook_params
    params.require(:ebook).permit!

  end



end