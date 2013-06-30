class UserAddColumnUsertype < ActiveRecord::Migration
  def up
  	add_column :users, :userType, :string, :null => false, :default => STRING_BUYER
  end

  def down
  	remove_column :users, :userType
  end
end
