class AddFileDownloadUrlToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :file_download_url, :string
    add_column :downloads, :slug, :string
  end
end
