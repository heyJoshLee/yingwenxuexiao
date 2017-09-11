class RenameAffiliatePaymentColumns < ActiveRecord::Migration
  def change

    rename_column :affiliate_payments, :payment_details, :details
    rename_column :affiliate_payments, :payment_receipt_number, :receipt_number
    rename_column :affiliate_payments, :payment_amount, :amount
  end
end
