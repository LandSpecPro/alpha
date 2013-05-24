class FeaturedItem < ActiveRecord::Base
	attr_accessible :description, :product_id, :location_id, :product_image_id, :size, :price
	belongs_to :product
	belongs_to :location

	geocoded_by :get_full_address
	after_validation :geocode

	has_one :product
	accepts_nested_attributes_for :product

	def get_image

		return ProductImage.find(self.product_image_id).image

	end

	def get_product
		return Product.find(self.product_id)
	end

	def get_full_address
		@location = Location.find(self.location_id)
		@address1 = @location.address1 + " "
		@address2 = @location.address2 + " "
		@city = @location.city + ", "
		@state = @location.state + " "
		@zip = @location.zip

		return @address1 + @address2 + @city + @state + @zip
	end
end
