class Location < ActiveRecord::Base
	attr_accessible :locName, :primaryPhone, :secondaryPhone, :fax, :address1, :address2, :city, :state, :zip, :primaryEmail, :secondaryEmail, :websiteLink, :facebookLink, :twitterLink, :googleLink, :bus_vendor_id
	belongs_to :bus_vendor
end
