class User < ActiveRecord::Base
	attr_accessible :login, :email, :password, :password_confirmation, :userType, :bus_vendor_attributes, :bus_buyer_attributes

	has_one :bus_vendor
	accepts_nested_attributes_for :bus_vendor
	has_one :bus_buyer
	accepts_nested_attributes_for :bus_buyer

  	acts_as_authentic do |c|
  		# Configuration options go here
  	end

  	def get_bus_name
  		if self.is_vendor
  			return self.bus_vendor.busName
  		elsif self.is_buyer
  			return self.bus_buyer.busName
  		else
  			return nil
  		end
  	end

  	def is_vendor
  		if self.userType == STRING_VENDOR
  			return true
  		else
  			return false
  		end
  	end

  	def is_buyer
  		if self.userType == STRING_BUYER
  			return true
  		else
  			return false
  		end
  	end

    def get_logo_or_profile_image
      if self.is_vendor
        return self.bus_vendor.logo
      elsif self.is_buyer
        return self.bus_buyer.profileImage
      else
        return nil
      end
    end  	
end
