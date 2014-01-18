class NewsFeedController < ApplicationController

	include ApplicationHelper
	include LocationHelper

	before_filter :require_user
  	before_filter :require_user_email_validated
  	before_filter :require_user_details
  	before_filter :require_supplier_has_location
  	before_filter :require_buyer_has_first_and_last_name
	
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
			if UserDetail.where(:id => params[:supplier]).count >= 1
				@items = NewsFeedItem.where(:user_id => UserDetail.where(:id => params[:supplier]).first.user_id).order('created_at DESC').offset(offset).limit(limit)
			else
				@items = NewsFeedItem.where(:user_id => -1)
			end
		else
			@items = NewsFeedItem.order('created_at DESC').offset(offset).limit(limit)
		end

		@following_location_ids = Follow.where(:user_id => current_user.id, :active => true).pluck(:location_id)
		@following = Location.where('id IN(?) AND active = true', @following_location_ids).order('"busName" ASC')

		@follower_user_ids = Follow.get_followers_user_ids_for_current_user(current_user.id)
		@followers = User.where('id IN(?) AND active = true', @follower_user_ids)

	end
	
end