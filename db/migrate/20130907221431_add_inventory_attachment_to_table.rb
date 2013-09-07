class AddInventoryAttachmentToTable < ActiveRecord::Migration
  def up
  	add_attachment :inventories, :file
  	add_column :inventories, :active, :boolean, :default => true, :null => false
  	add_column :inventories, :current, :boolean, :default => true, :null => false
  end

  def down
  	remove_attachment :inventories, :file
  	remove_column :inventories, :active
  	remove_column :inventories, :current
  end
end
