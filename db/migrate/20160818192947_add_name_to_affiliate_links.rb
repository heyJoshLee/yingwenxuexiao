class AddNameToAffiliateLinks < ActiveRecord::Migration
  def change
    add_column :affiliate_links, :name, :string
  end
end
