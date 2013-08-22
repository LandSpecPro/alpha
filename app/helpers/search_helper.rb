module SearchHelper

	def default_search_values

		if params[:query] == 'Search All'
			params[:query] = nil
		end

		if params[:page].blank?
			params[:page] = 1
		end

		if params[:per_page].blank?
			params[:per_page] = 10
		end

		if params[:sort].blank?
			params[:sort] = 'dist_asc'
		end

		if params[:current_location]
			params[:location] = request.location.city + ", " + request.location.state
		elsif params[:location].blank?
			params[:location] = 'Atlanta, GA'
		end

		if params[:distance_from].blank?
			params[:distance_from] = 9999
		end

		# if categories is blank, leave it blank

		if params[:view].blank? and not cookies.signed[:search_results_view]
			params[:view] = 'list'
			cookies.permanent.signed[:search_results_view] = params[:view]
		elsif params[:view].blank?
			params[:view] = cookies.signed[:search_results_view]
		end

	end

	def search_for_suppliers

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@locs = Location.geocoded.where(:active => true).sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
		params[:result_count] = @locs.count
		return @locs.limit(params[:per_page]).offset(@offset)

	end

	def find_supplier_by_bus_name

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@locs = Location.geocoded.where(:active => true, :busName => params[:query]).sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
		params[:result_count] = @locs.count
		return @locs.limit(params[:per_page]).offset(@offset)

	end

	def search_for_featured_items

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@prods = FeaturedItem.geocoded.where(:active => true).only_visible.sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
		params[:result_count] = @prods.count
		return @prods.limit(params[:per_page]).offset(@offset)

	end

	def find_featured_items_by_name

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@prods = FeaturedItem.geocoded.where(:active => true, :commonName => params[:query]).only_visible.sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
		params[:result_count] = @prods.count
		return @prods.limit(params[:per_page]).offset(@offset)

	end

	def last_page_number

		if not (params[:result_count].to_i % 10) == 0
			return (params[:result_count].to_i / params[:per_page].to_i) + 1
		else
			return (params[:result_count].to_i / params[:per_page].to_i)
		end

	end

	def min_paginate_number
		
		@minpage = params[:page].to_i - 3

		if @minpage <= 0
			@minpage = 1
		end

		return @minpage

	end

	def max_paginate_number

		@maxpage = params[:page].to_i + 3

		if @maxpage > last_page_number
			@maxpage = last_page_number
		end

		return @maxpage

	end

	def sort_by_url(search_type, sort)
		if search_type == 'supplier'
			return search_supplier_url(:page => 1, :per_page => params[:per_page], :query => params[:query], :view => params[:view], :current_location => params[:current_location], :distance_from => params[:distance_from], :location => params[:location], :sort => sort)
		elsif search_type == 'product'
			return search_product_url(:page => 1, :per_page => params[:per_page], :query => params[:query], :view => params[:view], :current_location => params[:current_location], :distance_from => params[:distance_from], :location => params[:location], :sort => sort)
		end
		# Currently goes back to first page
	end

	def per_page_url(search_type, per_page)
		if search_type == 'supplier'
			return search_supplier_url(:page => 1, :per_page => per_page, :query => params[:query], :view => params[:view], :current_location => params[:current_location], :distance_from => params[:distance_from], :location => params[:location], :sort => params[:sort])
		elsif search_type == 'product'
			return search_product_url(:page => 1, :per_page => per_page, :query => params[:query], :view => params[:view], :current_location => params[:current_location], :distance_from => params[:distance_from], :location => params[:location], :sort => params[:sort])
		end
		# Currently goes back to first page
	end

end

# COOKIES
#
# cookies.signed[:search_results_view] ---- can be 'list' or 'alternate'
#     Alternate will be Grid view for products, and Map view for suppliers, until I add Map View to suppliers, and then come up with slightly better
#      logic to determine the default view
#
# END COOKIES


#<% if not cookies.signed[:update_helppage] %>
#		$(showGritter('update_helppage'));
#		<% cookies.permanent.signed[:update_helppage] = true %>
#	<% elsif not cookies.signed[:update_publicprofiles] and current_user.is_vendor %>
#		$(showGritter('update_publicprofiles'));
#		<% cookies.permanent.signed[:update_publicprofiles] = true %>
#	<% end %>