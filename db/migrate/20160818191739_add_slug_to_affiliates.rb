class AddSlugToAffiliates < ActiveRecord::Migration
  def change
    add_column :affiliates, :slug, :string
  end
end
