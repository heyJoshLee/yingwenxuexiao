class AddImagesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :image_url, :string
  end
end
