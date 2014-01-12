class SearchController < ApplicationController

	include SearchHelper

	before_filter :require_user
  	before_filter :require_user_email_validated
  	before_filter :require_user_details
  	before_filter :require_supplier_has_location

  	before_filter :require_buyer_has_first_and_last_name
  
  	before_filter :default_search_values

	def product

		@path = search_product_path(:current_location => true)

		if params[:query].blank?
			@featured_items = search_for_featured_items
		else
			@featured_items = find_featured_items_by_name
		end

		store_location

	end

	def supplier

		@path = search_supplier_path(:current_location => true)

		if params[:query].blank?
			@locations = search_for_suppliers
		else
			@locations = find_supplier_by_bus_name
		end

		store_location

	end

end