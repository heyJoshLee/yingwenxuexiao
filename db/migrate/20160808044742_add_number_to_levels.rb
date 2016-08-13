class AddNumberToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :number, :integer
  end
end
