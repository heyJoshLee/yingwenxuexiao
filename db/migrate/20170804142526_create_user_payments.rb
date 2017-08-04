class CreateUserPayments < ActiveRecord::Migration
  def change
    create_table :user_payments do |t|
      t.timestamps
      t.integer :user_id, :payment_id
    end
  end
end
