class BusVendor < ActiveRecord::Base
	attr_accessible :busName, :logo

	# This method associates the attribute ":logo" with a file attachment
	has_attached_file :logo, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'
	}
end
