class CreateEmailSignups < ActiveRecord::Migration
  def change
    create_table :email_signups do |t|
      t.string :page, default: "not_set"
      t.string :email
      t.string :name, default: "not_given"
      t.string :campagin, default: "not_set"
      t.timestamps
    end
  end
end
