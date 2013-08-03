class FeaturedItemViewLog < ActiveRecord::Base
	attr_accessible :viewed_by_user_id, :featured_item_id
end
