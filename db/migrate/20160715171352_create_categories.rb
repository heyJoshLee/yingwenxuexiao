class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, :image_url
      t.text :description
      t.timestamps
    end
  end
end
