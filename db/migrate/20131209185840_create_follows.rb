class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|

    	t.timestamps
    	t.integer :user_id, :null => false
    	t.integer :location_id, :null => false
    	t.boolean :active, :null => false, :default => true

    end
  end
end
