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

end
