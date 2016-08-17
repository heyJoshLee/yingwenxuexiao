class Admin::Dashboard::DownloadsController < AdminController

  before_action :set_download, only: [:show, :update, :edit]
  
  def new
    @download = Download.new
  end

  def index
    add_breadcrumb "Downloads", admin_dashboard_downloads_path
    @downloads = Download.all
  end

  def show
    add_breadcrumb "Downloads", admin_dashboard_downloads_path
    add_breadcrumb @download.name, admin_dashboard_download_path(@download)
  end

  def create
    @download = Download.new(download_params)
    if @download.save
      flash[:success] = "download was saved"
      redirect_to admin_dashboard_download_path(@download)
    else
      flash.now[:danger] = "There was a problem and the download was not saved"
      render :new
    end
  end

  def edit
    add_breadcrumb "Downloads", admin_dashboard_downloads_path
    add_breadcrumb @download.name, admin_dashboard_download_path(@download)
  end

  def update
    if @download.update(download_params)
      flash[:success] = "Download was updated successfully."
      redirect_to admin_dashboard_download_path(@download)
    else
      flash.now[:danger] = "There was and error and it didn't save"
      render "edit"
    end
  end

  private

  def set_download
    @download = Download.find_by(slug: params[:id])
  end

  def download_params
    params.require(:download).permit!
  end

end