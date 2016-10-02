class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text, default: "This user has not filled out a bio yet."
  end
end
