class SearchController < ApplicationController

	include SearchHelper
  
  	before_filter :default_search_values

	def product

		@path = search_product_path(:current_location => true)
		@featured_items = search_for_featured_items

	end

	def supplier

		@path = search_supplier_path(:current_location => true)

		if params[:query].blank?
			@locations = search_for_suppliers
		else
			@locations = find_supplier_by_bus_name
		end

	end

end
