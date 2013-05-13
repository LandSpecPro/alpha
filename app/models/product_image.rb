class ProductImage < ActiveRecord::Base
	attr_accessible :product_id, :image
	belongs_to :product

	has_attached_file :image, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'},
		:default_style => :square
end
