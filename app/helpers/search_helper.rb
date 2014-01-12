module SearchHelper

	def default_search_values

		if params[:query] == 'All Suppliers' or params[:query] == 'All Featured Items'
			params[:query] = nil
		end

		if params[:page].blank?
			params[:page] = 1
		end

		if params[:per_page].blank?
			params[:per_page] = 10
		end

		if params[:sort].blank?
			if params[:search_type] == 'product'
				params[:sort] = 'newest_first'
			else
				params[:sort] = 'dist_asc'
			end
		end

		if params[:current_location]
			geoip = GeoIP.new('lib/GeoLiteCity.dat').city(request.remote_ip)
			if not geoip.blank?
				params[:location] = geoip.city_name + ", " + geoip.region_name
			else
				params[:location] = 'Atlanta, GA'
			end
		elsif params[:location].blank?
			params[:location] = 'Atlanta, GA'
		end

		if params[:distance_from].blank?
			params[:distance_from] = 9999
		end

		# if categories is blank, leave it blank

		if not params[:view].blank?
			cookies.permanent.signed[:search_results_view] = params[:view]
		elsif params[:view].blank? and cookies.signed[:search_results_view]
			params[:view] = cookies.signed[:search_results_view]
			cookies.permanent.signed[:search_results_view] = params[:view]
		else
			params[:view] = 'alt'
		end

	end

	def search_for_suppliers

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@locs = get_location_by_cache.geocoded.sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])

		unless params[:categories].blank?
			@locs = @locs.filter_by_categories(params[:categories])
		end

		#Get center point for map
		@center = Geocoder::Calculations.geographic_center(@locs)

		unless @locs.blank?
			params[:result_count] = @locs.count
			update_search_log
			if params[:view] == 'alt'
				#Get center point for map
				@center = Geocoder::Calculations.geographic_center(@locs)
				return @locs
			else
				return @locs.limit(params[:per_page]).offset(@offset)
			end
		else
			params[:result_count] = 0
			update_search_log
			return nil
		end



	end

	def find_supplier_by_bus_name

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@locs = get_location_by_cache.geocoded.where(:busName => params[:query]).sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])

		unless params[:categories].blank?
			@locs = @locs.filter_by_categories(params[:categories])
		end

		unless @locs.blank?
			params[:result_count] = @locs.count
			update_search_log
			if params[:view] == 'alt'
				#Get center point for map
				@center = Geocoder::Calculations.geographic_center(@locs)
				return @locs
			else
				return @locs.limit(params[:per_page]).offset(@offset)
			end
		else
			params[:result_count] = 0
			update_search_log
			return nil
		end	

	end

	def search_for_featured_items

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@prods = get_featured_items_by_cache.geocoded.only_visible.sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
		params[:result_count] = @prods.count
		update_search_log
		return @prods.limit(params[:per_page]).offset(@offset)

	end

	def find_featured_items_by_name

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@prods = get_featured_items_by_cache.geocoded.where(:commonName => params[:query]).only_visible.sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
		params[:result_count] = @prods.count
		update_search_log
		return @prods.limit(params[:per_page]).offset(@offset)

	end

	def get_location_by_cache

		if not Rails.cache.read('active_locations').blank?
			return Rails.cache.read('active_locations')
		else
			Location.update_cache
			return Location.where(:active => true)
		end

	end

	def get_featured_items_by_cache

		if not Rails.cache.read('active_featured_items').blank?
			return Rails.cache.read('active_featured_items')
		else
			FeaturedItem.update_cache
			return FeaturedItem.where(:active => true)
		end

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

	def change_view_url(search_type, view)
		if search_type == 'supplier'
			return search_supplier_url(:page => params[:page], :per_page => params[:per_page], :query => params[:query], :view => view, :current_location => params[:current_location], :distance_from => params[:distance_from], :location => params[:location], :sort => params[:sort])
		elsif search_type == 'product'
			return search_product_url(:page => params[:page], :per_page => params[:per_page], :query => params[:query], :view => view, :current_location => params[:current_location], :distance_from => params[:distance_from], :location => params[:location], :sort => params[:sort])
		end
	end

	def update_search_log
		if params[:commit]
			@log = SearchLog.new(:searchTerm => params[:query], :user_id => current_user.id, :location => params[:location], :distanceFrom => params[:distance_from], :searchType => params[:search_type], :categories => params[:categories], :numResults => params[:result_count], :resultsView => params[:view])
			@log.save
		end
	end

end

# COOKIES
#
# cookies.signed[:search_results_view] ---- can be 'list' or 'alt'
#     Alternate will be Grid view for products, and Map view for suppliers, until I add Map View to suppliers, and then come up with slightly better
#      logic to determine the default view
#
# END COOKIES


#<% if not cookies.signed[:update_helppage] %>
#		$(showGritter('update_helppage'));
#		<% cookies.permanent.signed[:update_helppage] = true %>
#	<% elsif not cookies.signed[:update_publicprofiles] and current_user.is_supplier %>
#		$(showGritter('update_publicprofiles'));
#		<% cookies.permanent.signed[:update_publicprofiles] = true %>
#	<% end %>