class ProductHasCategory < ActiveRecord::Base
	include ModelHelper
	
  	attr_accessible :featured_item_id, :category_id
  	belongs_to :location
  	belongs_to :category
end
