class Product < ActiveRecord::Base
	attr_accessible :commonName, :latinName, :altName, :featured_items_attributes, :location_id, :featured_item_id

	has_many :fav_products
	accepts_nested_attributes_for :fav_products
	has_and_belongs_to_many :product_categories
	accepts_nested_attributes_for :product_categories

	def get_all_images(pid)
		return ProductImage.all(:product_id => pid)
	end
end
