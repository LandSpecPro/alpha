class AddRequiredFieldsToLocations < ActiveRecord::Migration
  def up
  	change_column :locations, :address1, :string, :null => false
  	change_column :locations, :city, :string, :null => false
  	change_column :locations, :state, :string, :null => false
  	change_column :locations, :zip, :string, :null => false
  end

  def down
  	change_column :locations, :address1, :string, :null => true
  	change_column :locations, :city, :string, :null => true
  	change_column :locations, :state, :string, :null => true
  	change_column :locations, :zip, :string, :null => true
  end
end
