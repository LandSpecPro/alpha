class CreateClaimLocations < ActiveRecord::Migration
  def change
    create_table :claim_locations do |t|

    	t.string :user_login
    	t.string :user_email
    	t.string :user_type
    	t.string :bus_name
    	t.string :loc_phone
    	t.string :loc_address1
    	t.string :loc_address2
    	t.string :loc_city
    	t.string :loc_state
    	t.string :loc_zip
    	t.string :loc_website

    	t.string :claim_token

    	t.float :latitude
    	t.float :longitude    	

    	t.boolean :claimed, :default => false

    end
  end
end
