class Admin::Dashboard::LevelsController < AdminController

  before_action :set_level, only: [:show, :update, :edit]
  
  def index
    add_breadcrumb "Dashboard", root_path
    add_breadcrumb "Levels", admin_dashboard_levels_path 
    @levels = Level.all
  end

  def create
    @level = Level.new(level_params)
    if @level.save
      flash[:success] = "Level was saved"
      redirect_to admin_dashboard_levels_path
    else
      flash.now[:danger] = "There was a problem and the level was not saved"
      render :index
    end
  end


  private

  def set_level
    @level = Level.find_by(slug: params[:id])
  end

  def level_params
    params.require(:level).permit!
  end

end