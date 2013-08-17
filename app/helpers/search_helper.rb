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

		if params[:location].blank?
			params[:location] = 'atlanta, ga'
		end

		# if distance is blank, leave it blank

		# if categories is blank, leave it blank

		if params[:view].blank? and not cookies.signed[:search_results_view]
			params[:view] = 'list'
			cookies.permanent.signed[:search_results_view] = params[:view]
		else
			params[:view] = cookies.signed[:search_results_view]
		end

	end

	def search_for_suppliers

		if params[:page] == 1
			return Location.limit(params[:per_page]).order('created_at DESC')
		else
			@offset = (params[:page].to_i - 1) * params[:per_page].to_i
			return Location.limit(params[:per_page]).offset(@offset).order('created_at DESC')
		end

	end

	def search_for_featured_items

		if params[:page] == 1
			return FeaturedItem.limit(params[:per_page]).order('created_at DESC')
		else
			@offset = (params[:page].to_i - 1) * params[:per_page].to_i
			return Location.limit(params[:per_page]).offset(@offset).order('created_at DESC')
		end

	end

	def last_page_number

		if not (Location.count % 10) == 0
			return (Location.count / params[:per_page].to_i) + 1
		else
			return (Location.count / params[:per_page].to_i)
		end

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