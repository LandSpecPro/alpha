class AddAboutSettingToLocationSettings < ActiveRecord::Migration
  
  def up
  	add_column :location_public_settings, :show_about, :boolean, :default => true, :null => false
  end

  def down
  	remove_column :location_public_settings, :show_about
  end

end
