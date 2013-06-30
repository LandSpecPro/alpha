class FeaturedItemsRemoveRequirements < ActiveRecord::Migration
  def up
  	change_column :featured_items, :product_image_id, :integer, :null => true
  end

  def down
  	change_column :featured_items, :product_image_id, :integer, :null => false
  end
end
