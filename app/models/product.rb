class Product < ActiveRecord::Base
	attr_accessible :commonName, :latinName, :altName, :product_images_attributes, :featured_items_attributes, :fav_products_attributes, :product_categories_attributes

	has_many :product_images
	accepts_nested_attributes_for :product_images
	has_many :featured_items
	accepts_nested_attributes_for :featured_items
	has_many :fav_products
	accepts_nested_attributes_for :fav_products
	has_and_belongs_to_many :product_categories
	accepts_nested_attributes_for :product_categories
end
