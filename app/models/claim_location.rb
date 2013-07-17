class ClaimLocation < ActiveRecord::Base
  	attr_accessible :claimed

  	geocoded_by :get_full_address
  	after_validation :geocode

  	def self.search_with_distance_and_query(distance_from, query, user)

	    @locsnear = self.near('' + user.currentCity + ", " + user.currentState + ', US', distance_from).where(:claimed => false)
	    return @locsnear.search_all_locations(query).where(:claimed => false)

	end

	def self.search_with_distance_only(distance_from, user)

		return self.near('' + user.currentCity + ", " + user.currentState + ', US', distance_from).where(:claimed => false)

	end

	def self.search_with_query_only(query)

	    return self.search_all_locations(query).where(:claimed => false)
	    
	end

  	def get_full_address
		@address1 = self.loc_address1 + " "
		@address2 = self.loc_address2 + " "
		@city = self.loc_city + ", "
		@state = self.loc_state + " "
		@zip = self.loc_zip

		return @address1 + @address2 + @city + @state + @zip
	end

	def self.get_all_unclaimed
		return ClaimLocation.where(:claimed => false)
	end
	
end
