class AddMessagesToAffiliateLinks < ActiveRecord::Migration
  def change
    add_column :affiliate_links, :sign_up_message, :text
    add_column :affiliate_links, :upgrade_message, :text

  end
end
