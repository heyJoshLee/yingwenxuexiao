class AddSlugToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :slug, :string
  end
end
