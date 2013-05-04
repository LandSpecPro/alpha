class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :commonName, :null => false
    	t.string :latinName
    	t.string :altName
    	
      	t.timestamps
    end
  end
end
