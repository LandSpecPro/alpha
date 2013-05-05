class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
    	t.string :category, :null => :false
    	t.string :parentCategory, :null => :false
      	t.timestamps
    end
  end
end
