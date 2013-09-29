class CreateNewsFeedItems < ActiveRecord::Migration
  def change
    create_table :news_feed_items do |t|

    	t.string :item_type, :null => false
    	t.integer :item_id, :null => false
    	t.integer :user_id, :null => false
    	t.integer :location_id

      	t.timestamps
      	
    end
  end
end
