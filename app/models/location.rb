class Location < ActiveRecord::Base
	include ModelHelper
	include AnalyticsHelper
	
	include PgSearch
	pg_search_scope :search_all_locations, :against => :busName, :using => { :tsearch => {:prefix => true, :dictionary => "english"} }

	geocoded_by :get_full_address
	after_validation :geocode
	after_create :set_profile_url

	attr_accessible :locName, :public_url, :public_url_active, :searchWeight, :inventory, :busName, :bio, :primaryPhone, :secondaryPhone, :fax, :address1, :address2, :city, :state, :zip, :primaryEmail, :secondaryEmail, :websiteLink, :facebookLink, :twitterLink, :googleLink, :bus_vendor_id, :featured_items_attributes, :categories_attributes, :location_public_settings_attributes, :statuses_attributes
	belongs_to :bus_vendor

	has_attached_file :inventory,
		:path => 'vendors/:id/inventory/inventory_:basename.:extension'
	
	has_many :featured_items
	has_many :products, :through => :featured_items
	accepts_nested_attributes_for :featured_items

	has_many :statuses
	accepts_nested_attributes_for :statuses

	has_many :fav_locations
	accepts_nested_attributes_for :fav_locations

	has_one :location_public_setting
	accepts_nested_attributes_for :location_public_setting

	has_many :category_to_locations
	has_many :categories, :through => :category_to_locations
	accepts_nested_attributes_for :categories

	validates :locName, :uniqueness => { :scope => :bus_vendor_id, :message => "You have already added a location with this name!"}
	validates :public_url, :uniqueness => {:scope => :active, :message => "This URL is already in use!"}, :allow_nil => true

	validates_presence_of :address1, :message => "Must provide a valid address!"
	validates_presence_of :city, :message => "Must provide a valid city!"
	validates_presence_of :state, :message => "Must provide a valid state!"
	validates_presence_of :zip, :message => "Must provide a valid zip code!"
	validates_presence_of :primaryPhone, :message => "Must provide a valid phone number!"

	validates_format_of :primaryEmail, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|^$/i, :message => "Primary Email address is not valid."
	validates_format_of :secondaryEmail, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|^$/i, :message => "Secondary Email address is not valid."
	validates_format_of :public_url, :with => /\A([a-zA-Z0-9_]){3,25}\z/, :message => "URL can only contain numbers, letters, and underscores. Must be between 3 and 25 characters long."

	def set_profile_url
		self.public_url = eight_digit_random_number
		self.save
	end

	def self.search_with_distance_and_query(location, distance_from, query, user)

	    @locsnear = self.near(location, distance_from).where(:active => true)
	    return @locsnear.search_all_locations(query).where(:active => true)

	end

	def self.search_with_distance_only(location, distance_from, user)

		return self.near(location, distance_from).where(:active => true)

	end

	def self.search_with_query_only(query)

	    return self.search_all_locations(query).where(:active => true)
	    
	end

	def self.default_best_rank(location)

		@top20 = self.where(:active => true).order('"searchWeight" DESC').limit(20)

		@ignorezero = @top20.where('"searchWeight" > ?', 0)

		@nearest = @ignorezero.near(location, 100000).order("distance")

		@top3 = @nearest.limit(3)

		return @top3

	end

	
	def format_all_urls

		self.websiteLink = format_url(self.websiteLink)
		self.facebookLink = format_url(self.facebookLink)
	    self.twitterLink = format_url(self.twitterLink)
	    self.googleLink = format_url(self.googleLink)

	end

	def reset_fields_keep_errors(lid)

		@resetloc = Location.find(lid)

		self.errors.each do |field, msg|
			@resetloc.errors.add(field, msg)
		end

		return @resetloc

	end

	def format_url(urladdress)
		unless urladdress[/^http:\/\//] || urladdress[/^https:\/\//] || urladdress.blank?
	        urladdress = 'http://' + urladdress
	    end

	    return urladdress
	end

	def get_full_address
		@address1 = self.address1 + " "
		if not self.address2.blank?
			@address2 = self.address2 + " "
		else
			@address2 = " "
		end
		@city = self.city + ", "
		@state = self.state + " "
		@zip = self.zip

		return @address1 + @address2 + @city + @state + @zip
	end

	def get_featured_items

		return FeaturedItem.where(:location_id => self.id, :active => true)

	end

	def is_favorited(user)

		if FavLocation.where(:user_id => user.id, :location_id => self.id, :active => true).count > 0
			return true
		else
			return false
		end
	end

	def set_favorite(userid, locid)

		if FavLocation.where(:user_id => userid, :location_id => self.id, :active => false).count > 0
			FavLocation.where(:user_id => userid, :location_id => self.id).first.activate
		else
			@favloc = FavLocation.create(:user_id => userid, :location_id => self.id)
			if @favloc.save
				return true
			else
				return false
			end
		end

	end

	def get_current_status_string(locid)

		currentstatus = Status.where(:active => true, :location_id => locid).first

	    unless currentstatus.blank?
	      currentstatusstring = currentstatus.status
	    else
	      currentstatusstring = ''
	    end

	    return currentstatusstring

	end

	def get_current_status(locid)

		return Status.where(:active => true, :location_id => locid).first

	end

	def is_owner(user)

		unless user.is_vendor
			return false
		end

		if user.bus_vendor_id == self.bus_vendor_id
			return true
		else
			return false
		end
		
	end
end
