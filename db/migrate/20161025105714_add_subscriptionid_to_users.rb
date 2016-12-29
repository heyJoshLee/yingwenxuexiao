class AddSubscriptionidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscriptionid, :string
  end
end
