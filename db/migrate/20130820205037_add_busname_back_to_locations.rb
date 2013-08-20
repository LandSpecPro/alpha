class AddBusnameBackToLocations < ActiveRecord::Migration
  
  def up
  	add_column :locations, :busName, :string
  end

  def down
  	remove_column :locations, :busName
  end

end
