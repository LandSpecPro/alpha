class AddBioForLocations < ActiveRecord::Migration
  def up
  	add_column :locations, :bio, :text
  end

  def down
  	remove_column :locations, :bio
  end
end
