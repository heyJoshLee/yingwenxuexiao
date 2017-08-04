class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.timestamps
      t.string :slug, :stripe_id, :currency
      t.integer :user_id
      t.decimal :amount
    end
  end
end
