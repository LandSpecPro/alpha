class ProductImage < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :product_id, :image
	belongs_to :product

	has_attached_file :image, styles: {
		thumb: '100x100#',
		medium: '300x300#',
		large: '400x400#',
		wide: '600x200#'},
		:default_style => :medium

	validates_presence_of :image, :on => :create, :message => "An image is required when adding a new item."
end
