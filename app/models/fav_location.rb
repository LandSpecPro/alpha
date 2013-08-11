class FavLocation < ActiveRecord::Base
	include ModelHelper

	attr_accessible :user_id, :location_id
	belongs_to :user
	belongs_to :location

	def location
		return Location.find(self.location_id)
	end

	def self.update_active_status(user_id)

		self.where(:user_id => user_id, :active => true).each do |s|

			if not Location.find(s.location_id).active
				s.active = false
				s.save
			end

		end

		self.where(:user_id => user_id, :active => false).each do |s|

			if Location.find(s.location_id).active
				s.active = true
				s.save
			end
		end

	end

end
