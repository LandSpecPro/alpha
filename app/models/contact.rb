class Contact < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :firstName, :lastName, :primaryPhone, :secondaryPhone, :fax, :email
	belongs_to :location
end
