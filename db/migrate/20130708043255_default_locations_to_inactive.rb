class DefaultLocationsToInactive < ActiveRecord::Migration
  def up
  	change_column :locations, :active, :boolean, :default => false, :null => false
  end

  def down
  	change_column :locations, :active, :boolean, :default => true, :null => false
  end
end
