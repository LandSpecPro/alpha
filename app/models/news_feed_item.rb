class NewsFeedItem < ActiveRecord::Base

	attr_accessible :item_type, :item_id, :user_id, :location_id

end