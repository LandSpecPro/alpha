class BusVendor < ActiveRecord::Base
	attr_accessible :busName, :logo, :id
	belongs_to :user

	# This method associates the attribute ":logo" with a file attachment
	has_attached_file :logo, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'},
		:default_style => :square
end
