class AddGeolocationToModels < ActiveRecord::Migration
  def up

  	add_column :users, :latitude, :float
  	add_column :users, :longitude, :float

  	add_column :locations, :latitude, :float
  	add_column :locations, :longitude, :float

  	add_column :featured_items, :latitude, :float
  	add_column :featured_items, :longitude, :float
  end

  def down

  	remove_column :users, :latitude
  	remove_column :users, :longitude

  	remove_column :locations, :latitude
  	remove_column :locations, :longitude

  	remove_column :featured_items, :latitude
  	remove_column :featured_items, :longitude

  end
end
