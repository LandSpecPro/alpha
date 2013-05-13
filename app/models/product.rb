class Product < ActiveRecord::Base
	attr_accessible :commonName, :latinName, :altName, :featured_items_attributes, :location_id
	
	has_many :featured_items
	has_many :locations, :through => :featured_items
	accepts_nested_attributes_for :featured_items

	has_many :fav_products
	accepts_nested_attributes_for :fav_products
	has_and_belongs_to_many :product_categories
	accepts_nested_attributes_for :product_categories
end
