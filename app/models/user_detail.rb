class UserDetail < ActiveRecord::Base

	# Attributes
	attr_accessible :id, :user_id, :first_name, :last_name, :company_name, :phone_number, \
	:user_type, :user_category, :city, :state, :zip, :logo, :tagline

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

	after_save :update_location_bus_name

	def update_location_bus_name
		if self.user_type == STRING_SUPPLIER
			self.locations.each do |l|
				l.busName = self.company_name
				l.save
				l.featured_items.each do |fi|
					fi.set_bus_name
				end
			end
		end
	end

	def is_buyer
		if user_type == STRING_BUYER
			return true
		else
			return false
		end
	end

	def is_supplier
		if user_type == STRING_SUPPLIER
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
