class LocationViewLog < ActiveRecord::Base
	attr_accessible :viewed_by_user_id, :location_id
end
