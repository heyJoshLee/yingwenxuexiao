class ChangeEmailSignupsCampaginName < ActiveRecord::Migration
  def change
    rename_column :email_signups, :campagin, :campaign
  end
end
