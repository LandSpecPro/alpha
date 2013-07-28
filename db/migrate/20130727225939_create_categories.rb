class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

    	t.integer :parent_id, :default => -1, :null => false
    	t.integer :hierarchy_level, :default => 1, :null => false
    	t.string :cat_name, :default => 'err', :null => false
    	t.boolean :active, :default => true, :null => false
     	t.timestamps
    end
  end
end
