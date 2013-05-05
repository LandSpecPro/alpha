class UpdateModelRelations < ActiveRecord::Migration
  def up
  	#Users does not need id for one to many relation
  	remove_column :users, :search_log_id
  end

  def down
  	add_column :users, :search_log_id, :integer
  end
end
