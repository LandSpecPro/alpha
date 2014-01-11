class Follow < ActiveRecord::Base
	attr_accessible :user_id, :location_id, :active

	has_one :user
	has_one :location

	def self.is_user_following(user_id, location_id)
	
		if Follow.where(:user_id => user_id, :location_id => location_id, :active => true).count > 0
			return true
		else
			return false
		end

	end

	def self.get_followers_for_user(user_id)

		@locids = []

		user = User.find(user_id)

		if user.is_supplier
			user.bus_vendor.locations.each do |l|
				@locids << l.id
			end
		end

		return self.where('location_id IN(?) AND active = true', @locids)

	end

end
