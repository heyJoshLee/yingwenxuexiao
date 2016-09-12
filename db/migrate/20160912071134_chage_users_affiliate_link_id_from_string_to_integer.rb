class ChageUsersAffiliateLinkIdFromStringToInteger < ActiveRecord::Migration
  def change
    remove_column :users, :affiliate_link_id
    add_column :users, :affiliate_link_id, :integer
  end
end
