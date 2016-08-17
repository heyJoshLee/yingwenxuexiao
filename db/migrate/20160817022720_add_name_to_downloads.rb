class AddNameToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :name, :string
  end
end
