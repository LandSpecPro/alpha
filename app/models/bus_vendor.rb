class BusVendor < ActiveRecord::Base
	attr_accessible :busName, :logo, :locations_attributes
	belongs_to :user

	has_many :locations
	accepts_nested_attributes_for :locations

	# This method associates the attribute ":logo" with a file attachment
	has_attached_file :logo, styles: {
		smthumb: '50x50>',
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'},
		:default_style => :square
end
