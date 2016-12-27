class AddUnitIdToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :unit_id, :integer
  end
end
