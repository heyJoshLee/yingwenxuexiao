class AddCodeToAffiliateLink < ActiveRecord::Migration
  def change
    add_column :affiliate_links, :code, :string
  end
end
