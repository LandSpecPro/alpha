class Contact < ActiveRecord::Base
	attr_accessible :firstName, :lastName, :primaryPhone, :secondaryPhone, :fax, :email
	belongs_to :location
end
