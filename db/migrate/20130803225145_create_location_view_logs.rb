class CreateLocationViewLogs < ActiveRecord::Migration
  def change
    create_table :location_view_logs do |t|

    	t.integer :viewed_by_user_id, :null => false
    	t.integer :location_id, :null => false
    	t.timestamps
    	
    end
  end
end
