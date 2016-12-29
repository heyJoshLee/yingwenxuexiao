class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.timestamps
      t.string :interval, :name, :slug, :currency, :stripe_id
      t.integer :price
    end
  end
end
