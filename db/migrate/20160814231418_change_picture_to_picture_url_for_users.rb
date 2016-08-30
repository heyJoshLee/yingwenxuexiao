class ChangePictureToPictureUrlForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :picture, :picture_url
  end
end
