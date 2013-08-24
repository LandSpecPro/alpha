class AddMoreIndecesToLocationsAndFeaturedItems < ActiveRecord::Migration
  def up

  	add_index :locations, :id
  	add_index :locations, :bus_vendor_id
  	add_index :locations, :active
  	add_index :locations, :busName

  	add_index :featured_items, :id
  	add_index :featured_items, :location_id
  	add_index :featured_items, :product_id
  	add_index :featured_items, :product_image_id
  	add_index :featured_items, :active
  	add_index :featured_items, :commonName
  	add_index :featured_items, :busName

  	add_index :products, :id

  	add_index :product_images, :id
  	add_index :product_images, :product_id

  	add_index :categories, :id

  	add_index :category_to_locations, :id
  	add_index :category_to_locations, :category_id
  	add_index :category_to_locations, :location_id

  	add_index :bus_vendors, :id
  	add_index :bus_vendors, :user_id

  	add_index :bus_buyers, :id

  	add_index :users, :id
  	add_index :users, :userType

  	remove_index :users, :last_request_at
  	remove_index :users, :persistence_token
  	remove_index :users, :perishable_token
  	remove_index :user_sessions, :updated_at

  end

  def down

  	remove_index :locations, :id
  	remove_index :locations, :bus_vendor_id
  	remove_index :locations, :active
  	remove_index :locations, :busName

  	remove_index :featured_items, :id
  	remove_index :featured_items, :location_id
  	remove_index :featured_items, :product_id
  	remove_index :featured_items, :product_image_id
  	remove_index :featured_items, :active
  	remove_index :featured_items, :commonName
  	remove_index :featured_items, :busName

  	remove_index :products, :id

  	remove_index :product_images, :id
  	remove_index :product_images, :product_id

  	remove_index :categories, :id

  	remove_index :category_to_locations, :id
  	remove_index :category_to_locations, :category_id
  	remove_index :category_to_locations, :location_id

  	remove_index :bus_vendors, :id
  	remove_index :bus_vendors, :user_id

  	remove_index :bus_buyers, :id

  	remove_index :users, :id
  	remove_index :users, :userType

  	add_index :users, :last_request_at
  	add_index :users, :persistence_token
  	add_index :users, :perishable_token
  	add_index :user_sessions, :updated_at

  end
end
