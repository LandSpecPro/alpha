class UserDetail < ActiveRecord::Base

	# Attributes
	attr_accessible :first_name, :last_name, :company_name, :phone_number, :user_type, :user_category, :city, :state, :zip

	# Relations
	has_many :locations
	accepts_nested_attributes_for :locations

	belongs_to :user

	# This method associates the attribute ":logo" with a file attachment
	has_attached_file :logo, 
		styles: {
			smthumb: '50x50',
			thumb: '100x100>',
			medium: '300x300>'},
		:default_style => :thumb,
		:default_url => '/images/default/:attachment_:style.png',
		:path => 'vendors/:id/images/logos/:basename_:style.:extension'

	# Validation
	validates :phone_number, :format => { :with => /\A\([0-9]{3}\)\s[0-9]{3}\-[0-9]{4}\z/, :message => "A valid phone number is required." }
	validates_attachment_content_type :logo, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)!'

	# Default Methods
	before_create :set_user_type

	def set_user_type

		userType = self.user.userType

		if userType == 'Vendor' or userType == 'vendor' or userType == 'supplier' or userType == 'Supplier'
			self.user_type = 'Supplier'
		elsif userType == 'buyer' or userType == 'Buyer'
			self.user_type = 'Buyer'
		end

	end

	def is_buyer
		if user_type == 'Buyer'
			return true
		else
			return false
		end
	end

	def is_supplier
		if user_type == 'Supplier'
			return true
		else
			return false
		end
	end

	def has_state
		if self.state == '' or self.state == 'N/A'
			return false
		else
			return true
		end
	end

	def has_user_category
		if self.user_category == '' or self.user_category == 'N/A'
			return false
		else
			return true
		end
	end

	def has_company_name
		if self.company_name.blank?
			return false
		else
			return true
		end
	end

end
