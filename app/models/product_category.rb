class ProductCategory < ActiveRecord::Base
	attr_accessible :category, :parentCategory, :products_attributes
	has_and_belongs_to_many :products
end
