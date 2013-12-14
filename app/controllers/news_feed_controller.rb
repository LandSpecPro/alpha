class NewsFeedController < ApplicationController

	include BusVendorsHelper
	include ApplicationHelper

	before_filter :require_user
	before_filter :require_business
	
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
		elsif params[:only_following]
			@items = NewsFeedItem.only_following(current_user.id).order('created_at DESC').offset(offset).limit(limit)
		elsif params[:supplier]
			if User.where(:bus_vendor_id => params[:supplier]).count >= 1
				@items = NewsFeedItem.where(:user_id => User.where(:bus_vendor_id => params[:supplier]).first.id).order('created_at DESC').offset(offset).limit(limit)
			else
				@items = NewsFeedItem.where(:user_id => -1)
			end
		else
			@items = NewsFeedItem.order('created_at DESC').offset(offset).limit(limit)
		end

		@following = Follow.where(:user_id => current_user.id, :active => true)
			@followers = Follow.get_followers_for_user(current_user.id)


	end
	
end