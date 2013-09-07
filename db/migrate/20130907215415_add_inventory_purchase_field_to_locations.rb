class AddInventoryPurchaseFieldToLocations < ActiveRecord::Migration
  def up
  	add_column :locations, :is_subscribed_to_inventory, :boolean, :default => false, :null => false

  	remove_column :locations, :inventory_file_name
  	remove_column :locations, :inventory_content_type
  	remove_column :locations, :inventory_file_size
  	remove_column :locations, :inventory_updated_at
  end

  def down
  	remove_column :locations, :is_subscribed_to_inventory

  	add_column :locations, :inventory_file_name, :string
  	add_column :locations, :inventory_content_type, :string
  	add_column :locations, :inventory_file_size, :integer
  	add_column :locations, :inventory_updated_at, :datetime
  end
end
