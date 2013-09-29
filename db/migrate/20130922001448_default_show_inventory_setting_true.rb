class DefaultShowInventorySettingTrue < ActiveRecord::Migration
  def up
  	change_column :location_public_settings, :show_inventory, :boolean, :default => true, :null => false
  end

  def down
  	change_column :location_public_settings, :show_inventory, :boolean, :default => false, :null => false
  end
end
