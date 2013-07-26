class Location < ActiveRecord::Base
	include ModelHelper
	
	include PgSearch
	pg_search_scope :search_all_locations, :against => :busName, :using => { :tsearch => {:prefix => true, :dictionary => "english"} }

	geocoded_by :get_full_address
	after_validation :geocode

	attr_accessible :locName, :searchWeight, :inventory, :busName, :bio, :primaryPhone, :secondaryPhone, :fax, :address1, :address2, :city, :state, :zip, :primaryEmail, :secondaryEmail, :websiteLink, :facebookLink, :twitterLink, :googleLink, :bus_vendor_id, :featured_items_attributes, :statuses_attributes
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

	validates :locName, :uniqueness => { :scope => :bus_vendor_id, :message => "You have already added a location with this name!"}

	validates_presence_of :address1, :message => "Must provide a valid address!"
	validates_presence_of :city, :message => "Must provide a valid city!"
	validates_presence_of :state, :message => "Must provide a valid state!"
	validates_presence_of :zip, :message => "Must provide a valid zip code!"
	validates_presence_of :primaryPhone, :message => "Must provide a valid phone number!"

	validates_format_of :primaryEmail, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|^$/i, :message => "Primary Email address is not valid."
	validates_format_of :secondaryEmail, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|^$/i, :message => "Secondary Email address is not valid."

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
		@address2 = self.address2 + " "
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
