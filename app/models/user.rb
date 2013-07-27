class User < ActiveRecord::Base
	include ModelHelper

	attr_accessible :login, :email, :password, :password_confirmation, :profileImage, :userType, :currentState, :currentCity, :bus_vendor_attributes,    :bus_buyer_attributes, :search_logs_attributes, :fav_locations_attributes, :fav_products_attributes

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

	validates_presence_of :userType, :on => :create, :message => "You must select a user type."

  	# This method associates the attribute ":profileImage" with a file attachment
  	has_attached_file :profileImage, 
		styles: {
			smthumb: '50x50>',
			thumb: '100x100#',
			medium: '300x300#'},
		:default_style => :thumb,
		:default_url => '/images/default/logos_:style.png',
		:path => 'users/:id/images/:attachment/:basename_:style.:extension'

	validates_attachment_content_type :profileImage, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)!'

	acts_as_authentic do |c|
		c.login_field = :login
	end

	def self.find_by_username_or_email(login)
		User.find_by_login(login.downcase) || User.find_by_email(login.downcase)
	end

	def get_business
		if self.is_vendor
			return self.bus_vendor
		elsif self.is_buyer
			return self.bus_buyer
		else
			return nil
		end
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
		if self.userType == STRING_VENDOR or self.userType == 'Vendor' or self.userType == 'supplier' or self.userType == 'Supplier'
			return true
		else
			return false
		end
	end

	def is_buyer
		if self.userType == STRING_BUYER or self.userType == 'Buyer'
			return true
		else
			return false
		end
	end

	def owns_location(location)
		if self.is_vendor
			if self.get_business.id == location.bus_vendor_id
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def owns_featured_item(featureditem)
		if self.is_vendor
			if self.get_business.id == featureditem.get_location.bus_vendor_id
				return true
			else
				return false
			end
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

  def password_reset!
  	reset_perishable_token!
  	PasswordReset.password_reset_email(current_user).deliver
  end
end
