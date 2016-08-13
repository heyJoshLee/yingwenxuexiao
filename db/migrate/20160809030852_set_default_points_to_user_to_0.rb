class SetDefaultPointsToUserTo0 < ActiveRecord::Migration
  def change
    change_column_default :users, :points, 0
    change_column_default :users, :level, 1
  end
end
