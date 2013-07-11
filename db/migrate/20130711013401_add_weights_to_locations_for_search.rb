class AddWeightsToLocationsForSearch < ActiveRecord::Migration
  def up
  	add_column :locations, :searchWeight, :integer, :default => 0, :null => false
  end

  def down
  	remove_column :locations, :searchWeight
  end
end
