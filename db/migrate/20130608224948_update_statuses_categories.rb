class UpdateStatusesCategories < ActiveRecord::Migration
  def up

  	remove_column :statuses, :user_id
  	add_column :statuses, :location_id, :integer, :null => false

  	add_column :categories, :hierarchyLevel, :integer, :null => false, :default => 0

  end

  def down

  	add_column :statuses, :user_id, :integer
  	remove_column :statuses, :location_id

  	remove_column :categories, :hierarchyLevel
  	
  end
end
