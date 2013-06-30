class LocationHasCategory < ActiveRecord::Base
	include ModelHelper

	attr_accessible :location_id, :category_id
	belongs_to :location
	belongs_to :category
end
