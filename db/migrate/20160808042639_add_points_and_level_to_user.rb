class AddPointsAndLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :points, :integer
    add_column :users, :level, :integer
  end
end
