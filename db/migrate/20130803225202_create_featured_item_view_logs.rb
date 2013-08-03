class CreateFeaturedItemViewLogs < ActiveRecord::Migration
  def change
    create_table :featured_item_view_logs do |t|

    	t.integer :viewed_by_user_id, :null => false
    	t.integer :featured_item_id, :null => false
    	t.timestamps

    end
  end
end
