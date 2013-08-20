module SearchHelper

	def default_search_values

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
		else
			params[:view] = cookies.signed[:search_results_view]
		end

	end

	def search_for_suppliers

		@offset = (params[:page].to_i - 1) * params[:per_page].to_i
		@locs = Location.geocoded.sort_by_criteria(params[:sort]).near(params[:location], params[:distance_from])
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

		if params[:page] == 1
			params[:num_pages] 
			return FeaturedItem.limit(params[:per_page]).order('created_at DESC')
		else
			@offset = (params[:page].to_i - 1) * params[:per_page].to_i
			return Location.limit(params[:per_page]).offset(@offset).order('created_at DESC')
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