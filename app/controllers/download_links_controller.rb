class DownloadLinksController < ApplicationController

  before_action :set_download_link, only: [:show, :update, :edit, :start_download]
  before_action :set_download, only: [:update, :edit]

  def show
    if @download_link.first_access.nil?
      @download_link.first_access = DateTime.now
    end

    @download_link.most_recent_access = DateTime.now
    @download_link.save
  end

  def start_download
    @download_link.downloaded = true
    @download_link.downloaded_time = DateTime.now
    @download_link.save
    redirect_to @download_link.download.file_download_url
  end

  private

  def set_download_link
    @download_link = DownloadLink.find_by(slug: params[:id])
  end

  def download_link_params
    params.require(:download_link).permit!
  end

  def set_download
    @download = @download_link.download
  end

end