class CreateFavProducts < ActiveRecord::Migration
  def change
    create_table :fav_products do |t|
    	t.integer :user_id, :null => false
    	t.integer :product_id, :null => false
      	t.timestamps
    end
  end
end
