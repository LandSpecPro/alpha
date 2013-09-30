class NewsFeedController < ApplicationController

	include BusVendorsHelper
	
	def main

		store_location

		if params[:only_featured_items]
			@items = NewsFeedItem.where(:item_type => NEW_FEATURED_ITEM).order('created_at DESC')
		elsif params[:only_new_suppliers]
			@items = NewsFeedItem.where(:item_type => NEW_SUPPLIER).order('created_at DESC')
		elsif params[:only_locations]
			@items = NewsFeedItem.where(:item_type => NEW_LOCATION).order('created_at DESC')
		elsif params[:only_inventories]
			@items = NewsFeedItem.where("item_type = ? or item_type = ?", FIRST_INVENTORY, NEW_INVENTORY).order('created_at DESC')
		else
			@items = NewsFeedItem.order('created_at DESC')
		end

	end
	
end