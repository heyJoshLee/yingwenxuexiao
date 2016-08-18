class CreateSupportTickets < ActiveRecord::Migration
  def change
    create_table :support_tickets do |t|
      t.timestamps
      t.string :email, :subject, :name
      t.text :body
    end
  end
end
