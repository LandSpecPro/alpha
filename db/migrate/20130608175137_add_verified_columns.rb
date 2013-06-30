class AddVerifiedColumns < ActiveRecord::Migration
  def up
  	add_column :bus_vendors, :verified, :boolean, :null => false, :default => false
  	add_column :bus_buyers, :verified, :boolean, :null => false, :default => false
  	add_column :products, :verified, :boolean, :null => false, :default => false
  	add_column :product_images, :verified, :boolean, :null => false, :default => false
  	add_column :users, :verified, :boolean, :null => false, :default => false
    add_column :locations, :verified, :boolean, :null => false, :default => false
  end

  def down
  	remove_column :bus_vendors, :verified
  	remove_column :bus_buyers, :verified
  	remove_column :products, :verified
  	remove_column :product_images, :verified
  	remove_column :users, :verified
    remove_column :locations, :verified
  end
end
