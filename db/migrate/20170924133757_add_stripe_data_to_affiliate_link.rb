class AddStripeDataToAffiliateLink < ActiveRecord::Migration
  def change
    add_column :affiliate_links, :data_amount, :string, default: "75000"
    add_column :affiliate_links, :data_currency, :string, default: "ntd"
    add_column :affiliate_links, :data_description, :string, default: "英文學校課程費用"
    add_column :affiliate_links, :stripe_plan_id, :string, default: "1"
  end
end
