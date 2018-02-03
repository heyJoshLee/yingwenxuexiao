class CreateEbooks < ActiveRecord::Migration
  def change
    create_table :ebooks do |t|
      t.timestamps
      t.string :title, :cover_img, :src
      t.text :description
    end
  end
end
