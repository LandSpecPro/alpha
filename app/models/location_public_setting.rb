class LocationPublicSetting < ActiveRecord::Base

	attr_accessible :show_company_logo, :show_tagline, :show_about, :show_full_address, :show_city_and_state, :show_state_only, :show_primary_phone, :show_secondary_phone, :show_fax, :show_primary_email, :show_secondary_email, :show_website, :show_facebook, :show_twitter, :show_google, :show_featured_items, :show_featured_items_price, :show_featured_items_size, :show_featured_items_description, :show_categories, :show_other_locations, :location_id

	belongs_to :location

end
