class Admin::Dashboard::VideosController < AdminController

  before_action :set_video, only: [:show, :create, :edit, :update]

  add_breadcrumb "Dashboard", :admin_dashboard_path
  add_breadcrumb "Videos", :admin_dashboard_videos_path


  def index
    @video = Video.new
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "Video has been created."
      redirect_to admin_dashboard_videos_path
    else
      flash.now[:error] = "There was a problem and the video was not saved."
      render :new 
    end
  end

  def update
    if @video.update(video_params)
      flash[:success] = "Video was saved."
      redirect_to admin_dashboard_video_path(@video)
    else
      flash.now[:danger] = "There was a problem and the video was not saved."
      render :edit
    end
  end


  private

  def set_video
    @video = Video.find_by(slug: params[:id])    
  end

  def video_params
    params.require(:video).permit!
  end

end