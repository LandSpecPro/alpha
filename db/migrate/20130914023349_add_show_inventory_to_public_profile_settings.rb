class AddShowInventoryToPublicProfileSettings < ActiveRecord::Migration
  
  def up
  	add_column :location_public_settings, :show_inventory, :boolean, :default => false, :null => false
  end

  def down
  	remove_column :location_public_settings, :show_inventory
  end

end
