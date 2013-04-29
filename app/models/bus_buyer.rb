class BusBuyer < ActiveRecord::Base
  	attr_accessible :busName, :profileImage, :id
	belongs_to :user

	# This method associates the attribute ":profileImage" with a file attachment
	has_attached_file :profileImage, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>'
	}
end
