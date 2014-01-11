class AddNewFieldsForUserDetailsLocations < ActiveRecord::Migration
  
  def up
  	add_column :locations, :user_detail_id, :integer
  	add_column :locations, :claimed, :boolean, :default => true, :null => false
  end

  def down
  	remove_column :locations, :user_detail_id
  	remove_column :locations, :claimed
  end

end
