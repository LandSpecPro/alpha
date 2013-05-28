class FavProduct < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :user_id, :product_id, :featured_item_id
	belongs_to :user
	belongs_to :product

	def product
		return Product.find(self.product_id)
	end

	def featured_item
		return FeaturedItem.find(self.featured_item_id)
	end
end
