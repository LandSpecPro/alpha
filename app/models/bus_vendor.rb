class BusVendor < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :busName, :busPhone, :logo, :tagline, :locations_attributes, :featured_items_attributes
	belongs_to :user

	has_many :locations
	accepts_nested_attributes_for :locations

	has_many :featured_items
	accepts_nested_attributes_for :featured_items

	# This method associates the attribute ":logo" with a file attachment
	has_attached_file :logo, 
		styles: {
			smthumb: '50x50',
			thumb: '100x100>',
			medium: '300x300>'},
		:default_style => :thumb,
		:default_url => '/images/default/:attachment_:style.png',
		:path => 'vendors/:id/images/logos/:basename_:style.:extension'

	validates_presence_of :busName, :message => "You must provide a valid business to use LandSpec!"
	validates :busPhone, :format => { :with => /\A\([0-9]{3}\)\s[0-9]{3}\-[0-9]{4}\z/, :message => "Must provide a valid phone number!" }
	validates_attachment_content_type :logo, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'File type is not allowed (only jpeg/png/gif images)!'

end
