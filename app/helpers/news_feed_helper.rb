module NewsFeedHelper

	def news_feed_uploaded_inventory(locid, invid)
		if Inventory.where(:location_id => locid).count == 1
			first_inventory_uploaded(locid, invid)
		else
			new_inventory_uploaded(locid, invid)
		end
	end

	private
	def first_inventory_uploaded(locid, invid)
		@item = NewsFeedItem.create(:location_id => locid, :user_id => current_user.id, :item_id => invid, :item_type => FIRST_INVENTORY)
	end

	private
	def new_inventory_uploaded(locid, invid)
		@item = NewsFeedItem.create(:location_id => locid, :user_id => current_user.id, :item_id => invid, :item_type => NEW_INVENTORY)
	end

	def news_feed_new_featured_item(locid, fid)
		@item = NewsFeedItem.create(:location_id => locid, :user_id => current_user.id, :item_id => fid, :item_type => NEW_FEATURED_ITEM)
	end
	
end
