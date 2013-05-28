class Location < ActiveRecord::Base
	include ModelHelper
	
	include PgSearch
	pg_search_scope :search_all_locations, :against => :locName, :using => { :tsearch => {:prefix => true, :dictionary => "english"} }

	geocoded_by :get_full_address
	after_validation :geocode

	attr_accessible :locName, :primaryPhone, :secondaryPhone, :fax, :address1, :address2, :city, :state, :zip, :primaryEmail, :secondaryEmail, :websiteLink, :facebookLink, :twitterLink, :googleLink, :bus_vendor_id, :featured_items_attributes
	belongs_to :bus_vendor
	
	has_many :featured_items
	has_many :products, :through => :featured_items
	accepts_nested_attributes_for :featured_items

	has_many :fav_locations
	accepts_nested_attributes_for :fav_locations

	validates_presence_of :locName, :on => :create, :message => "Must provide a name for this location!"
	validates :locName, :uniqueness => { :scope => :bus_vendor_id, :message => "You have already added a location with this name!"}

	validates_presence_of :address1, :on => :create, :message => "Must provide a valid address!"
	validates_presence_of :city, :on => :create, :message => "Must provide a valid city!"
	validates_presence_of :state, :on => :create, :message => "Must provide a valid state!"
	validates_presence_of :zip, :on => :create, :message => "Must provide a valid zip code!"

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

		if locid == self.id
			@favloc = FavLocation.create(:user_id => userid, :location_id => self.id)
			if @favloc.save
				return true
			else
				return false
			end
		else
			return false
		end

	end

	def remove_favorite(userid, locid)

		if locid == self.id
			FavLocation.destroy(FavLocation.where(:user_id => userid, :location_id => self.id).first.id)
			@favloc = FavLocation.where(:user_id => userid, :location_id => self.id).first.id
			@favloc.deactivate
		else
			return false
		end
	end


end
