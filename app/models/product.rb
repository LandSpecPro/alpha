class Product < ActiveRecord::Base
	include ModelHelper
	
	include PgSearch	
	pg_search_scope :search_all_products, :against => [:commonName, :latinName, :altName], :using => { :tsearch => {:prefix => true, :dictionary => "english"} }

	attr_accessible :commonName, :latinName, :altName, :featured_items_attributes, :location_id, :featured_item_id

	has_many :product_images
	accepts_nested_attributes_for :product_images

	has_many :fav_products
	accepts_nested_attributes_for :fav_products
	has_and_belongs_to_many :categories
	accepts_nested_attributes_for :categories

	has_many :featured_items
	accepts_nested_attributes_for :featured_items

	def get_all_images
		return ProductImage.where(:product_id => self.id, :active => true)
	end

	def search_all(query)
		@products = Product.search_all_products(query)
		return @products.where(:active => true)
	end

end
