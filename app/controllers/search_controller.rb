class SearchController < ApplicationController

	include SearchHelper
  
  	before_filter :default_search_values

	def product

	end

	def supplier

		@locations = search_for_suppliers.order('created_at DESC')

	end

	def search

		cookies.permanent.signed[:search_results_view] = params[:view]

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
