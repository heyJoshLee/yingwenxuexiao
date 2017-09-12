class CreateAffiliatePayments < ActiveRecord::Migration
  def change
    create_table :affiliate_payments do |t|
      t.timestamps
      t.datetime :paid_date
      t.text :payment_details
      t.string :payment_receipt_number, :payment_amount, :slug
      t.integer :affiliate_link_id, :user_id
      t.boolean :paid, default: false
    end
  end
end
