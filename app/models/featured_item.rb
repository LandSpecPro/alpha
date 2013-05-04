class FeaturedItem < ActiveRecord::Base
	attr_accessible :description, :location_id, :product_id, :product_image_id
	belongs_to :product
	belongs_to :location
	has_one :product_image
end
