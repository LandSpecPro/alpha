class CreateFeaturedItems < ActiveRecord::Migration
  def change
    create_table :featured_items do |t|
    	t.integer :location_id, :null => false
    	t.integer :product_id, :null => false
    	t.integer :product_image_id, :null => false
    	t.text :description
      	t.timestamps
    end
  end
end
