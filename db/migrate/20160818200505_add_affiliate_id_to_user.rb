class AddAffiliateIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :affiliate_link_id, :string
  end
end
