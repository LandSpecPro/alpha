class User < ActiveRecord::Base
	attr_accessible :login, :email, :password, :password_confirmation, :profileImage, :userType, :bus_vendor_attributes,    :bus_buyer_attributes, :search_logs_attributes, :fav_locations_attributes, :fav_products_attributes

	has_one :bus_vendor, :dependent => :destroy
	accepts_nested_attributes_for :bus_vendor
	has_one :bus_buyer, :dependent => :destroy
	accepts_nested_attributes_for :bus_buyer
	has_many :search_logs
	accepts_nested_attributes_for :search_logs
	has_many :fav_locations
	accepts_nested_attributes_for :fav_locations
	has_many :fav_products
	accepts_nested_attributes_for :fav_products

  # This method associates the attribute ":profileImage" with a file attachment
  has_attached_file :profileImage, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'},
    :default_style => :square

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

  def get_logo
    if self.is_vendor
      return self.bus_vendor.logo
    elsif self.is_buyer
      return self.bus_buyer.logo
    else
      return nil
    end
  end  	
end
