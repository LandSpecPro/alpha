class AddUserBusVendorRelation < ActiveRecord::Migration
  def up
  	add_column :users, :bus_vendor_id, :integer
  	add_column :bus_vendors, :user_id, :integer
  end

  def down
  	remove_column :users, :bus_vendor_id
  	remove_column :bus_vendors, :user_id
  end
end
