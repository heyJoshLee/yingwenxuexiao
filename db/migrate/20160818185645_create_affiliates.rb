class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.timestamps
      t.string :name, :contact_email, :contact_name, :domain
      t.text :notes
    end
  end
end
