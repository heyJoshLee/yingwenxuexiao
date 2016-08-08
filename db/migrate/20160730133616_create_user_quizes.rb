class CreateUserQuizes < ActiveRecord::Migration
  def change
    create_table :user_quizes do |t|
      t.integer :user_id, :quiz_id
    end
  end
end
