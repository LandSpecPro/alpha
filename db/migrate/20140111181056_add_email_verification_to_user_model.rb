class AddEmailVerificationToUserModel < ActiveRecord::Migration
  
  def up
  	add_column :users, :is_email_verified, :boolean, :null => false, :default => false
  end

  def down
  	remove_column :users, :is_email_verified
  end

end
