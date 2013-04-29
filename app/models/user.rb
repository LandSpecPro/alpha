class User < ActiveRecord::Base
	attr_accessible :login, :email, :password, :password_confirmation, :userType, :bus_vendor_attributes

	has_one :bus_vendor
	accepts_nested_attributes_for :bus_vendor

  	acts_as_authentic do |c|
  		# Configuration options go here
  	end
  	
end
