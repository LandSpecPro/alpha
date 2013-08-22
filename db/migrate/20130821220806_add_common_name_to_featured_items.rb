class AddCommonNameToFeaturedItems < ActiveRecord::Migration
  
  def up
  	add_column :featured_items, :commonName, :string
  end

  def down
  	remove_column :featured_items, :commonName
  end

end
