class AddPublicUrlColumnsToLocations < ActiveRecord::Migration
  
  def up
  	add_column :locations, :public_url, :string
  	add_column :locations, :public_url_active, :boolean, :default => false, :null => false
  end

  def down
  	remove_column :locations, :public_url
  	remove_column :locations, :public_url_active
  end

end