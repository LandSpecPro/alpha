class NewsFeedController < ApplicationController

	include BusVendorsHelper
	
	def main

		store_location

		if params[:offset]
			offset = params[:offset]
		else
			offset = 0
		end

		if params[:limit]
			limit = params[:limit]
		else
			limit = 50
		end

		if params[:only_featured_items]
			@items = NewsFeedItem.where(:item_type => NEW_FEATURED_ITEM).order('created_at DESC').offset(offset).limit(limit)
		elsif params[:only_new_suppliers]
			@items = NewsFeedItem.where(:item_type => NEW_SUPPLIER).order('created_at DESC').offset(offset).limit(limit)
		elsif params[:only_locations]
			@items = NewsFeedItem.where(:item_type => NEW_LOCATION).order('created_at DESC').offset(offset).limit(limit)
		elsif params[:only_inventories]
			@items = NewsFeedItem.where("item_type = ? or item_type = ?", FIRST_INVENTORY, NEW_INVENTORY).order('created_at DESC').offset(offset).limit(limit)
		else
			@items = NewsFeedItem.order('created_at DESC').offset(offset).limit(limit)
		end

	end
	
end