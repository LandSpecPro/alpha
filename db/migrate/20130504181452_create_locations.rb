class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
    	t.string :locName, :null => false
    	t.integer :primaryPhone
    	t.integer :secondaryPhone
    	t.integer :fax
    	t.string :address1
    	t.string :address2
    	t.string :city
    	t.string :state
    	t.integer :zip
    	t.string :primaryEmail
    	t.string :secondaryEmail
    	t.string :websiteLink
    	t.string :facebookLink
    	t.string :twitterLink
    	t.string :googleLink
      	t.timestamps
    end
  end
end
