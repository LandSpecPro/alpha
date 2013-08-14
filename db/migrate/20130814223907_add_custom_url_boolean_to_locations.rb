class AddCustomUrlBooleanToLocations < ActiveRecord::Migration
  def up
  	add_column :locations, :url_is_custom, :boolean, :default => false, :null => false
  end

  def down
  	remove_column :locations, :url_is_custom
  end
end
