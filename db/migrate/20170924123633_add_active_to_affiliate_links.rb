class AddActiveToAffiliateLinks < ActiveRecord::Migration
  def change
    add_column :affiliate_links, :active, :boolean, default: true
  end
end
