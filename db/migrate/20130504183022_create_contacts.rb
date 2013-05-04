class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.integer :location_id, :null => false
    	t.string :firstName, :null => false
    	t.string :lastName
    	t.integer :primaryPhone
    	t.integer :secondaryPhone
    	t.integer :fax
    	t.string :email
      	t.timestamps
    end
  end
end
