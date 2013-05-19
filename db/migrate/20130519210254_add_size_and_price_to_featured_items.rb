class AddSizeAndPriceToFeaturedItems < ActiveRecord::Migration
  def up
  	add_column :featured_items, :size, :string
  	add_column :featured_items, :price, :integer
  end

  def down
  	remove_column :featured_items, :size
  	remove_column :featured_items, :price
  end
end
