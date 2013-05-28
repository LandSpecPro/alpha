class ProductImage < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :product_id, :image
	belongs_to :product

	has_attached_file :image, styles: {
		thumb: '100x100#',
		square: '200x200#',
		medium: '300x300>'},
		:default_style => :square

	validates_presence_of :image, :on => :create, :message => "An image is required when adding a new item."
end
