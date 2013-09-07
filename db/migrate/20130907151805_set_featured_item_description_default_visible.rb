class SetFeaturedItemDescriptionDefaultVisible < ActiveRecord::Migration
  def up
  	change_column :location_public_settings, :show_featured_items_description, :boolean, :default => true, :null => false
  end

  def down
  	change_column :location_public_settings, :show_featured_items_description, :boolean, :default => false, :null => false
  end
end
