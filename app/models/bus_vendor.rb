class BusVendor < ActiveRecord::Base
	attr_accessible :busName, :logo, :locations_attributes
	belongs_to :user

	has_many :locations
	accepts_nested_attributes_for :locations

	# This method associates the attribute ":logo" with a file attachment
	has_attached_file :logo, 
		styles: {
			smthumb: '50x50>',
			thumb: '100x100>',
			medium: '300x300#'},
		:default_style => :thumb,
		:default_url => '/images/default/:attachment_:style.png',
		:path => 'vendors/:id/images/logos/:basename_:style.:extension'

	validates_presence_of :busName, :on => :create, :message => "You must provide a valid business to use LandSpec!"
end
