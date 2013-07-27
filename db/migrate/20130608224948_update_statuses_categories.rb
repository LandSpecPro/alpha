class UpdateStatusesCategories < ActiveRecord::Migration
  def up

  	remove_column :statuses, :user_id
  	add_column :statuses, :location_id, :integer, :null => false

  end

  def down

  	add_column :statuses, :user_id, :integer
  	remove_column :statuses, :location_id
  	
  end
end
