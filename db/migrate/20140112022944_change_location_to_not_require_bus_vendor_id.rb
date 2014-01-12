class ChangeLocationToNotRequireBusVendorId < ActiveRecord::Migration

  def up
  	change_column :locations, :bus_vendor_id, :integer, :null => true
  end

  def down
  	change_column :locations, :bus_vendor_id, :integer, :null => false
  end
end
