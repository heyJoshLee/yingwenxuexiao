class SendDownloadLinkEmailWorker
  include Sidekiq::Worker


  def perform(download_link_id)
    download_link  =DownloadLink.find(download_link_id)
    puts "Found download link"
    puts "#{download_link}"
    download_link.send_email
  end

end