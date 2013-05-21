class FavProduct < ActiveRecord::Base
	attr_accessible :user_id, :product_id
	belongs_to :user
	belongs_to :product

	def product
		return Product.find(self.product_id)
	end
end
