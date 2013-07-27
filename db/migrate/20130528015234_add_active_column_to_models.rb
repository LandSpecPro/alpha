class AddActiveColumnToModels < ActiveRecord::Migration
  def up
  	add_column :users, :active, :boolean, :default => true, :null => false
  	add_column :bus_buyers, :active, :boolean, :default => true, :null => false
  	add_column :bus_vendors, :active, :boolean, :default => true, :null => false
  	add_column :contacts, :active, :boolean, :default => true, :null => false
  	add_column :fav_locations, :active, :boolean, :default => true, :null => false
  	add_column :fav_products, :active, :boolean, :default => true, :null => false
  	add_column :featured_items, :active, :boolean, :default => true, :null => false
  	add_column :locations, :active, :boolean, :default => true, :null => false
  	add_column :products, :active, :boolean, :default => true, :null => false
  	add_column :product_images, :active, :boolean, :default => true, :null => false
  	add_column :search_logs, :active, :boolean, :default => true, :null => false
  end

  def down
  	remove_column :users, :active
  	remove_column :bus_buyers, :active
  	remove_column :bus_vendors, :active
  	remove_column :contacts, :active
  	remove_column :fav_locations, :active
  	remove_column :fav_products, :active
  	remove_column :featured_items, :active
  	remove_column :locations, :active
  	remove_column :products, :active
  	remove_column :product_images, :active
  	remove_column :search_logs, :active
  end
end
