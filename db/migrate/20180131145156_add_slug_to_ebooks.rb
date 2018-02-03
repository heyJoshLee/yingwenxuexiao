class AddSlugToEbooks < ActiveRecord::Migration
  def change
    add_column :ebooks, :slug, :string
  end
end
