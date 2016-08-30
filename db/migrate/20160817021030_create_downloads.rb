class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.timestamps
      t.string :main_image_url, :title, :description
      t.boolean :active, default: true
    end
  end
end
