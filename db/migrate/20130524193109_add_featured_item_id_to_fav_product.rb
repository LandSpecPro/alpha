class AddFeaturedItemIdToFavProduct < ActiveRecord::Migration
  def up
  	add_column :fav_products, :featured_item_id, :integer
  end

  def down
  	remove_column :fav_products, :featured_item_id
  end
end
