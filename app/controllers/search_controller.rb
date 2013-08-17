class SearchController < ApplicationController

	include SearchHelper
  
  	before_filter :default_search_values

	def product

		@path = search_product_path
		#@featured_items = method_that_searches_in_search_helper_based_on_criteria
		@featured_items = search_for_featured_items

	end

	def supplier

		@path = search_supplier_path
		#@locations = method_that_searches_in_search_helper_based_on_criteria
		@locations = search_for_suppliers

	end

	def search

		if params[:search_type] == 'supplier'
			redirect_to search_supplier_url(:query => params[:query])
			return
		elsif params[:search_type] == 'product'
			redirect_to search_product_url(:query => params[:query])
			return
		else
			redirect_to oops_url
			return
		end

	end
end
