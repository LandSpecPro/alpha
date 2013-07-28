class DropCategoryTables < ActiveRecord::Migration
  def change
  	drop_table :categories
  	drop_table :product_categories
  	drop_table :product_has_categories
  	drop_table :location_has_categories
  end
end
