class Admin::CategoriesController < AdminController
  
  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "category was saved"
      redirect_to category_path(@category)
    else
      flash.now[:danger] = "There was a problem and the category was not saved"
      render :new
    end
  end

  def edit
    @category = Category.find_by(slug: params[:id])
  end

  private

  def category_params
    params.require(:category).permit!
  end

end
