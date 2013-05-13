class FeaturedItem < ActiveRecord::Base
	attr_accessible :description, :product_id, :location_id
	belongs_to :product
	belongs_to :location
end
