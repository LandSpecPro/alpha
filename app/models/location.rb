class Location < ActiveRecord::Base
	include PgSearch
	attr_accessible :locName, :primaryPhone, :secondaryPhone, :fax, :address1, :address2, :city, :state, :zip, :primaryEmail, :secondaryEmail, :websiteLink, :facebookLink, :twitterLink, :googleLink, :bus_vendor_id, :featured_items_attributes
	belongs_to :bus_vendor

	
	has_many :featured_items
	has_many :products, :through => :featured_items
	accepts_nested_attributes_for :featured_items

	validates_presence_of :locName, :on => :create, :message => "Must provide a name for this location!"
	validates :locName, :uniqueness => { :scope => :bus_vendor_id, :message => "You have already added a location with this name!"}

	validates_presence_of :address1, :on => :create, :message => "Must provide a valid address!"
	validates_presence_of :city, :on => :create, :message => "Must provide a valid city!"
	validates_presence_of :state, :on => :create, :message => "Must provide a valid state!"
	validates_presence_of :zip, :on => :create, :message => "Must provide a valid zip code!"

	def get_featured_items

		return FeaturedItem.where(:location_id => self.id)

	end

end
