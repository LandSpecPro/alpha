class Product < ActiveRecord::Base
	include ModelHelper

	attr_accessible :commonName, :latinName, :altName, :featured_items_attributes, :location_id, :featured_item_id

	has_many :product_images
	accepts_nested_attributes_for :product_images

	has_many :featured_items
	accepts_nested_attributes_for :featured_items

	def get_all_images
		return ProductImage.where(:product_id => self.id, :active => true)
	end

	def has_active_featureditem

		@featureditems = FeaturedItem.where(:active => true, :product_id => self.id)

		@featureditems.each do |fi|
			if fi.is_visible
				return true
			end
		end

		return false

	end

end
