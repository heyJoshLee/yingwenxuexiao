class CreateDownloadLinks < ActiveRecord::Migration
  def change
    create_table :download_links do |t|
      t.timestamps
      t.string :email
      t.datetime :first_access, :most_recent_access, :downloaded_time
      t.boolean :downloaded, default: false
      t.integer :download_id
    end
  end
end
