class AddInstructionsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :instructions, :text
  end
end
