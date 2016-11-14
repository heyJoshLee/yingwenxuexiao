class AddPreviewTextToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :preview_text, :text
  end
end
