class UserDetail < ActiveRecord::Base

	attr_accessible :first_name, :last_name, :company_name, :phone_number, :user_type, :user_category, :city, :state, :zip

	has_many :locations
	accepts_nested_attributes_for :locations

	belongs_to :user

	validates :phone_number, :format => { :with => /\A\([0-9]{3}\)\s[0-9]{3}\-[0-9]{4}\z/, :message => "A valid phone number is required." }

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
