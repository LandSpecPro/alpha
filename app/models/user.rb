class User < ActiveRecord::Base
	include ModelHelper

	attr_accessible :id, :active, :verified, :is_email_verified, :login, :email, :password, \
	:password_confirmation, :profileImage, :userType, :user_detail_attributes, :search_logs_attributes, \
	:bus_vendor_attributes, :bus_buyer_attributes

	#NEW
	has_one :user_detail, :dependent => :destroy
	accepts_nested_attributes_for :user_detail

	has_one :bus_vendor
	accepts_nested_attributes_for :bus_vendor
	has_one :bus_buyer
	accepts_nested_attributes_for :bus_buyer

	has_many :search_logs
	accepts_nested_attributes_for :search_logs

	validates_presence_of :userType, :message => "You must select a user type."

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

		c.merge_validates_format_of_email_field_options :message => 'Email address is invalid.'
		c.merge_validates_uniqueness_of_email_field_options :message => 'This email is already in use.'

		c.merge_validates_length_of_login_field_options :minimum => 4, :message => 'Username must at least 4 characters long.'
		c.merge_validates_uniqueness_of_login_field_options :message => 'Username is already in use.'
		c.validates_format_of_login_field_options :with => /\A[a-zA-Z0-9_-]*\z/, :message => 'Username can only contain letters, numbers, underscores, and hyphens.'

		c.merge_validates_confirmation_of_password_field_options :message => 'Passwords did not match.'
		c.validates_length_of_password_confirmation_field_options :minimum => 0, :maximum => 5000, :message => 'Password Confirmation is either less than 0 or greater than 5000. Either way, that\'s not right.'

	end

	def self.find_by_username_or_email(login)
		User.find_by_login(login.downcase) || User.find_by_email(login.downcase)
	end	

	def get_bus_name
		return self.user_detail.company_name
	end

	def is_supplier
		if self.userType == STRING_SUPPLIER
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

	def owns_location(location)
		if self.is_supplier
			if self.user_detail.id == location.user_detail_id
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def owns_featured_item(featureditem)
		if self.is_supplier
			if self.user_detail.id == featureditem.get_location.user_detail_id
				return true
			else
				return false
			end
		else
			return false
		end
	end

  def get_logo
  	return self.user_detail.logo
  end  	

  def password_reset!
  	reset_perishable_token!
  	PasswordReset.password_reset_email(current_user).deliver
  end
end
