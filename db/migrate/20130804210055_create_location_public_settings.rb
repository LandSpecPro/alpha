class CreateLocationPublicSettings < ActiveRecord::Migration
  def change
    create_table :location_public_settings do |t|

    	t.boolean :show_company_logo, :default => true, :null => false
    	t.boolean :show_tagline, :default => true, :null => false
    	t.boolean :show_full_address, :default => true, :null => false
    	t.boolean :show_city_and_state, :default => false, :null => false
    	t.boolean :show_state_only, :default => false, :null => false
    	t.boolean :show_primary_phone, :default => true, :null => false
    	t.boolean :show_secondary_phone, :default => false, :null => false
    	t.boolean :show_fax, :default => false, :null => false
    	t.boolean :show_primary_email, :default => true, :null => false
    	t.boolean :show_secondary_email, :default => false, :null => false
    	t.boolean :show_website, :default => true, :null => false
    	t.boolean :show_facebook, :default => true, :null => false
    	t.boolean :show_twitter, :default => true, :null => false
    	t.boolean :show_google, :default => true, :null => false
    	t.boolean :show_featured_items, :default => true, :null => false
    	t.boolean :show_featured_items_price, :default => false, :null => false
    	t.boolean :show_featured_items_size, :default => false, :null => false
    	t.boolean :show_featured_items_description, :default => false, :null => false
    	t.boolean :show_categories, :default => true, :null => false
    	t.boolean :show_other_locations, :default => false, :null => false

        t.integer :location_id, :null => false

    	t.timestamps
    end
  end
end
