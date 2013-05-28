class FavLocation < ActiveRecord::Base
	include ModelHelper

	attr_accessible :user_id, :location_id
	belongs_to :user
	belongs_to :location

	def location
		return Location.find(self.location_id)
	end

end
