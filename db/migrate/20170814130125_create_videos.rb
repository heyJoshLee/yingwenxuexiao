class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.timestamps
      t.string :url, :title, :slug
    end
  end
end
