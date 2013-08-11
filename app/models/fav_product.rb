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

	def self.update_active_status(user_id)

		self.where(:user_id => user_id, :active => true).each do |s|

			if not FeaturedItem.find(s.featured_item_id).active
				s.active = false
				s.save
			end

		end

		self.where(:user_id => user_id, :active => false).each do |s|

			if FeaturedItem.find(s.featured_item_id).active
				s.active = true
				s.save
			end
			
		end

	end
end
