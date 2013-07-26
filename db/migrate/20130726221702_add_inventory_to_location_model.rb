class AddInventoryToLocationModel < ActiveRecord::Migration
	
  def up
  	add_attachment :locations, :inventory
  end

  def down
  	remove_attachment :locations, :inventory
  end

end
