class AddSlugToDownloadLinks < ActiveRecord::Migration
  def change
    add_column :download_links, :slug, :string
  end
end
