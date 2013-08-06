class RemoveDefaultForUsertypeOnUsers < ActiveRecord::Migration
  def up
  	change_column :users, :userType, :string, :default => '', :null => false
  end

  def down
  	change_column :users, :userType, :string, :default => 'buyer', :null => false
  end
end
