class ChangeDefaultMembershipLevelForUserToFree < ActiveRecord::Migration
  def change
    change_column_default :users, :membership_level, "free"
  end
end
