class LocationNameNotRequired < ActiveRecord::Migration
  def up
  	change_column :locations, :locName, :string, :null => true
  end

  def down
  	change_column :locations, :locName, :string, :null => false
  end
end
