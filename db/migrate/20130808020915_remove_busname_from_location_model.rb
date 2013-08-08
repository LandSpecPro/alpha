class RemoveBusnameFromLocationModel < ActiveRecord::Migration
 
  def up
  	remove_column :locations, :busName
  end

  def down
  	add_column :locations, :busName, :string, :null => false
  end

end
