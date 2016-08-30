class AddSlugToSupportTickets < ActiveRecord::Migration
  def change
    add_column :support_tickets, :slug, :string
  end
end
