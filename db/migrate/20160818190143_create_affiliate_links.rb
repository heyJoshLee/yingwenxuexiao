class CreateAffiliateLinks < ActiveRecord::Migration
  def change
    create_table :affiliate_links do |t|
      t.timestamps
      t.integer :affiliate_id, :signups
      t.string :url, :slug, :url
    end
  end
end
