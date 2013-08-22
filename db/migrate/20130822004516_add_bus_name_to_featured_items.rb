class AddBusNameToFeaturedItems < ActiveRecord::Migration
  
  def up
  	add_column :featured_items, :busName, :string
  end

  def down
  	remove_column :featured_items, :busName
  end
  
end
