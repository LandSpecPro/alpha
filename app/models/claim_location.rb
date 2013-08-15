class ClaimLocation < ActiveRecord::Base
  	attr_accessible :claimed

  	geocoded_by :get_full_address
  	after_validation :geocode


  	def get_full_address
		@address1 = self.loc_address1 + " "
		if not self.loc_address2.blank?
			@address2 = self.loc_address2 + " "
		else
			@address2 = ""
		end
		@city = self.loc_city + ", "
		@state = self.loc_state + " "
		@zip = self.loc_zip

		return @address1 + @address2 + @city + @state + @zip
	end

	def self.get_all_unclaimed
		return ClaimLocation.where(:claimed => false)
	end
	
end
