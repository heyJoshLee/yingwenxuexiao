class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :name
      t.string :role, default: "reader"
      t.string :membership_level, default: "none"
      t.timestamps
    end
  end
end
