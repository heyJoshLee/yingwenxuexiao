class AddStripeCustomerIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_customer_id, :string
    add_column :subscriptions, :items_sold, :jsonb
    add_column :subscriptions, :plan, :jsonb
    add_column :subscriptions, :quantity, :integer
  end
end
