class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|

    	t.integer :location_id
    	t.integer :num_views

    	t.timestamps
    end
  end
end
