class SetAffiliateLinkSignupsDefulatTo0 < ActiveRecord::Migration
  def change
    change_column_default :affiliate_links, :signups, 0
  end
end
