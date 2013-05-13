class FeaturedItem < ActiveRecord::Base
	attr_accessible :description, :product_id, :location_id, :product_image_id
	belongs_to :product
	belongs_to :location

	has_one :product
	accepts_nested_attributes_for :product

	def get_image

		return ProductImage.find(self.product_image_id).image

	end

	def get_product
		return Product.find(self.product_id)
	end

end
