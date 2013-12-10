class NewsFeedItem < ActiveRecord::Base

	attr_accessible :item_type, :item_id, :user_id, :location_id, :created_at

	def self.only_following(user_id)
		return NewsFeedItem.joins('INNER JOIN follows ON follows.location_id = news_feed_items.location_id WHERE follows.active = true AND follows.user_id = ' + user_id.to_s)
	end

end