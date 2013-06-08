class AddCompanyNameToLocations < ActiveRecord::Migration
  def up
  	add_column :locations, :busName, :string, :null => false
  end

  def down
  	remove_column :locations, :busName
  end
end
